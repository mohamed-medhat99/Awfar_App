import 'package:awfarapp/constants.dart';
import 'package:awfarapp/provider/cartitems.dart';
import 'package:awfarapp/screen/user/Homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awfarapp/Models/product.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'cartscreen.dart';
class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
    body: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(product.purl),
          ),
        ) ,
        Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * .1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),

                Text(product.pName.toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, CartScreen.id , arguments: _quantity);
                  },
                  child: Icon(
                    Icons.shopping_cart,
                  ),
                ),

              ],
            ),

          ),
        ),
       Positioned(
         bottom: 0,
         child: Column(
           children: <Widget>[
             Opacity(
               child: Container(
                 color: Colors.white,
                 height: MediaQuery.of(context).size.height *0.3,
                 width: MediaQuery.of(context).size.width,
                 child: Padding(
                   padding: EdgeInsets.all(20),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       Text(product.pName ,
                       style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                       ),
                       ),
                       Text('${product.pPrice} \$',
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       Text(product.pDescription,
                         style: TextStyle(
                           fontSize: 20,
                           fontWeight: FontWeight.bold,
                         ),
                       ),
                       SizedBox(
                       height: 50,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           ClipOval(
                             child: Material(
                               color: Klogincolor,
                               child: GestureDetector(
                                 onTap: add,

                                 child: SizedBox(
                                   child: Icon(
                                       Icons.add
                                   ),
                                   height:28 ,
                                   width: 28,
                                 ),
                               ),
                             ),
                           ),
                           Text(
                             _quantity.toString(),
                             style: TextStyle(
                               fontSize: 35,
                             ),
                           ),
                           ClipOval(
                             child: Material(
                               color: Klogincolor,
                               child: GestureDetector(
                                 onTap:subtract,
                                 child: SizedBox(
                                   child: Icon(
                                       Icons.remove
                                   ),
                                   height:28 ,
                                   width: 28,
                                 ),
                               ),
                             ),
                           ),
                         ],
                       )
                     ],
                   ),
                 ),
               ),
               opacity: 0.5,
             ),
             ButtonTheme(
               minWidth: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height * .1,
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
                     AddToCart(context , product);
                   },
                  color: Colors.white,
                   child: Text('add to cart'.toUpperCase(),
                   style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold),
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),
      ],

    ),

    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;

      });
    }
  }

  add() {
    setState(() {
      _quantity++;

    });
  }

  void AddToCart(context , product) {
    CartItems cartitem = Provider.of<CartItems>(context ,listen: false);
    product.pquantity = _quantity;
    bool exist = false;
    var productsInCart = cartitem.products;
    for (var productInCart in productsInCart) {
      if (productInCart.pName == product.pName) {
        exist = true;
      }
    }
    if(exist == true){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Item already Added to your cart'),
      ));
    }else
      {
        cartitem.addProducts(product);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Added to Cart succfully'),
        ));
      }
  }
  }

