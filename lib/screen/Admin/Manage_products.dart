import 'package:awfarapp/Models/product.dart';
import 'package:awfarapp/Widgets/Custome_Menu.dart';
import 'package:awfarapp/screen/Admin/Edit_products.dart';
import 'package:awfarapp/screen/Admin/add_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:awfarapp/constants.dart';
import 'package:awfarapp/services/fire_store.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path/path.dart';


class ManageProducts extends StatefulWidget {
  static String id = 'ManageProducts';

  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
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
                purl: data[Kproductimage],
              ));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2 ,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) => Padding(
                padding:EdgeInsets.symmetric(vertical: 8 , horizontal: 8),
                child: GestureDetector(
                  onTapUp: (details){
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dxx = MediaQuery.of(context).size.width- dx;
                    double dyy = MediaQuery.of(context).size.width- dy;
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dxx, dyy),
                        items:
                      [
                        mypopupitem(
                        child: Text('Edit'),
                          onclick: (){
                             Navigator.pushNamed(context, EditProducts.id , arguments: products[index]);
                          },
                      ),
                        mypopupitem(
                          child: Text('Delete'),
                          onclick: (){
                            _store.deleteProduct(products[index].documentid);
                          },
                        ),
                      ],
                    );
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
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                               Text(products[index].pName , style: TextStyle(fontWeight: FontWeight.bold),),
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
      ),
    );
  }
}

