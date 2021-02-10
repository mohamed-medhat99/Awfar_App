import 'package:awfarapp/Models/product.dart';
import 'package:awfarapp/Widgets/productsview.dart';
import 'package:awfarapp/screen/LoginScreen.dart';
import 'package:awfarapp/screen/user/productinfo.dart';
import 'package:awfarapp/services/auth.dart';
import 'package:awfarapp/services/fire_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awfarapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awfarapp/screen/user/cartscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fuctions.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabbarindex = 0;
  int _bottombarindex = 0;
  final _auth = Auth();
  final _store = Store();
  List<Product> _products;
  FirebaseUser _loggiedusser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _bottombarindex,

              onTap: (value) async{
                if(value == 2 ){
                  SharedPreferences ref  = await SharedPreferences.getInstance();
                  ref.clear();
                  await _auth.LogOut();
                  Navigator.popAndPushNamed(context , LoginScreen.id);
                }
                setState(() {
                  _bottombarindex = value;
                });
              },
              fixedColor: Klogincolor,
              items: [
                BottomNavigationBarItem(
                  title: Text('test'),
                  icon: Icon(Icons.group),
                ),
                BottomNavigationBarItem(
                  title: Text('test'),
                  icon: Icon(Icons.group),
                ),
                BottomNavigationBarItem(
                  title: Text('Log Out'),
                  icon: Icon(Icons.exit_to_app),
                ),
              ],
            ),
            appBar: AppBar(

              backgroundColor: Colors.white,

              elevation: 0,
              bottom: TabBar(
                labelColor: Colors.black,
                indicatorColor: Klogincolor,
                onTap: (value) {
                  setState(() {
                    _tabbarindex = value;
                  });
                },
                tabs: <Widget>[
                  Text('Jackets',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('shoes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('trousers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                  Text('T-shirts',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                jacketView(),
                productView(Kshoes , _products),
                productView(Ktrousers , _products),
                productView(ktshirts , _products),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'discover'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(
                        Icons.shopping_cart,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    getCurrentuser();
  }

  getCurrentuser() async {
    _loggiedusser = await _auth.getUser();
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Product(
                documentid: doc.documentID,
                pPrice: data[KproductPrice],
                pName: data[KproductName],
                pCategory: data[KproductCategory],
                pDescription: data[KproductDescription],
                purl: data[Kproductimage]));
                }
            _products = [...products];
            products.clear();
           products = getproductbyCategory(Kjackets ,_products);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) =>
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: GestureDetector(
                   onTap: (){
                     Navigator.pushNamed(context, ProductInfo.id ,arguments: products[index]);
                   },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                products[index].purl
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: 0.6,
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 50,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(products[index].pName, style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                  Text('${products[index].pPrice}\$'),
                                  Text(products[index].pCategory),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            itemCount: products.length,
          );
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }


}
