
import 'dart:io';
import 'package:awfarapp/screen/Admin/OrdersScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:awfarapp/screen/Admin/add_product.dart';
import 'package:awfarapp/screen/Admin/Manage_products.dart';
import 'package:flutter/material.dart';
import 'package:awfarapp/Widgets/rounder_button.dart';
import 'package:awfarapp/constants.dart';
import 'package:image_downloader/image_downloader.dart';

class AdminHome extends StatefulWidget {
  static String id = 'AdminHome';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     body: Center(
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 24.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: <Widget>[
             SizedBox(
               width: double.infinity,
             ),
             Container(
               height: MediaQuery.of (context).size.height*0.3,
               child: Stack(
                 alignment: Alignment.center,
                 children: <Widget>[
                   Image(
                     image: AssetImage('images/logo/icons8-buy-50.png'),
                   ),
                   Positioned(
                     bottom: 0,
                     child: Text('Awfar',
                       style: TextStyle(
                         fontFamily: 'ArchitectsDaughter-Regular',
                         fontSize: 50.0,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
             SizedBox(

             ),
             Roundedbuttons(
               onPressed: (){
                 Navigator.pushNamed(context, AddProduct.id);
               },
               coluer: Colors.white,
               title: 'Add product',
             ),
             Roundedbuttons(
               onPressed: (){
                 Navigator.pushNamed(context, ManageProducts.id);

               },

               coluer: Colors.white,
               title: 'Edit product',

             ),
             Roundedbuttons(
               onPressed: (){
                 Navigator.pushNamed(context, OrdersScreen.id);
               },
               coluer: Colors.white,
               title: 'view orders',

             ),
           ],
         ),
       ),
     ),
    );
  }

//  void loadimage() async{
//    var imageId = await ImageDownloader.downloadImage(_url);
//    var path = await ImageDownloader.findPath(imageId);
//    File image = File(path);
//    setState(() {
//      _image = image;
//    });
//  }
}
