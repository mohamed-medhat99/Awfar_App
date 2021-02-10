import 'package:awfarapp/Models/orders.dart';
import 'package:awfarapp/Models/product.dart';
import 'package:awfarapp/Widgets/Custome_Menu.dart';
import 'package:awfarapp/constants.dart';
import 'package:awfarapp/provider/cartitems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awfarapp/screen/user/productinfo.dart';
import 'package:awfarapp/Models/product.dart';
import 'package:awfarapp/services/fire_store.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final _store = Store();

  @override

  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItems>(context).products;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statuesbarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Klogincolor,
        title:Center(child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.body1,
            children: [
              TextSpan(text: 'My Cart ' ,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(Icons.shopping_cart),
                ),
              ),
            ],
          ),
        )),
      ),
      body: Column(
        children: <Widget>[
          LayoutBuilder(
            builder:(context , constrains) {
              if(products.isNotEmpty){
              return  Container(
                  height: screenHeight -
                  statuesbarHeight -
                  appBarHeight-
                      (screenHeight *.08),
                  child: ListView.builder(itemBuilder:
                      (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTapUp: (details){

                          showCustomMenu(details , context , products[index]);
                        },
                        child: Container(
                          height: screenHeight * .15,
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: screenHeight * .15 / 2,
                                backgroundImage: NetworkImage(products[index].purl),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          Text(
                                            products[index].pName,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            '\$ ${products[index].pPrice}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        products[index].pquantity.toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                    itemCount: products.length,
                  ),

              );
              } else {
                return Container(
                  height: screenHeight -
                      (screenHeight * .08) -
                      appBarHeight -
                      statuesbarHeight,
                  child: Center(
                    child: Text('Your Cart is Empty'),
                  ),
                );
              }
            }),
          Builder(
            builder: (context)=>ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: screenHeight * .08,
              child: Builder(
                builder:(context)=> RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft:  Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                  ),
                  onPressed: (){
                    showcustomdealouge(products , context);
                  },
                  color: Colors.grey,
                  child: Text("Prceed To CheckOut".toUpperCase(),
                    style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
//          RaisedButton(
//           onPressed: (){},
//            child: Text(
//              'proceed to checkout',
//            ),
//          ),
        ],
      ),
    );
  }

  void showCustomMenu( details,context, product) async{

    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dxx = MediaQuery.of(context).size.width- dx;
    double dyy = MediaQuery.of(context).size.width- dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(dx, dy, dxx, dyy),
      items:
      [
        mypopupitem(
          child: Text('Edit'),
          onclick: (){
            Navigator.pop(context);
            Provider.of<CartItems>(context , listen: false).deleteProduct(product);
            Navigator.pushNamed(context, ProductInfo.id  , arguments: product);
          },
        ),
        mypopupitem(
          child: Text('Delete'),
          onclick: (){
            Navigator.pop(context);
            Provider.of<CartItems>(context , listen: false).deleteProduct(product);
          },
        ),
      ],
    );
  }

  void showcustomdealouge(List<Product> product ,context) async{
    var totalprice = getTotaoPrice(product);
    String address;
    String Name;
    AlertDialog alert = AlertDialog(
      actions: <Widget>[
        MaterialButton(
          onPressed: (){
            Store _store = Store();
            _store.addOrderss({
              Ktotalprice : totalprice,
              Kaddress : address,
            }, product);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('items ordered succefully'),
            ));
            Navigator.pop(context);
          },
          child: Text('confirm'),
        ),
      ],
      title: Text('Total Price =  $totalprice \$'),
      content: Column(
        children: <Widget>[
          TextField(
            onChanged: (value){
              address =value;
            },
            decoration: InputDecoration(
              hintText: 'enter your address',
            ) ,
          ),
          TextField(
            onChanged: (value){
              Name =value;
            },
            decoration: InputDecoration(
              hintText: 'enter your full name',
            ) ,
          ),
        ],
      ),

    );
    await showDialog(context: context ,builder: (context){
     return alert;
    });
  }

  getTotaoPrice(List<Product> product) {
var price = 0;

for(var product in product){
  price += product.pquantity * int.parse(product.pPrice);
}
return price;
  }
}
