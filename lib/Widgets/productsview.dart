import 'package:awfarapp/Models/product.dart';
import 'package:awfarapp/screen/user/productinfo.dart';
import 'package:flutter/material.dart';
import '../fuctions.dart';

Widget productView( String pCategory , List<Product> allproducts) {
  List <Product> products;
  products = getproductbyCategory(pCategory,allproducts);
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
}