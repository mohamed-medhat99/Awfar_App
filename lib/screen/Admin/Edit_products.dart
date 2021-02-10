import 'dart:io';
import 'package:awfarapp/Models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:awfarapp/constants.dart';
import 'package:awfarapp/Widgets/inputtext.dart';
import 'package:awfarapp/Widgets/rounder_button.dart';
import 'package:awfarapp/services/fire_store.dart';
import 'package:awfarapp/Models/product.dart';
class EditProducts extends StatefulWidget {
  static String id = 'Editproduct';

  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {

  final _store = Store();

  String _name , _price , _description , _category ;


  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

 Product products = ModalRoute.of(context).settings.arguments;

    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _globalkey,
          child: ListView(
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
                height: height*.01,
              ),
              TextFields(
                hinttext: 'product name',
                OnClick: (value){
                  _name = value;
                },
              ),
              SizedBox(
                height: height*.01,
              ),
              TextFields(
                hinttext: 'product price',
                OnClick: (value){
                  _price = value;
                },
              ),
              SizedBox(
                height: height*.01,
              ),
              TextFields(
                hinttext: 'product description',
                OnClick: (value){
                  _description = value;
                },
              ),
              SizedBox(
                height: height*.01,
              ),
              TextFields(
                hinttext: 'product category',
                OnClick: (value){
                  _category = value;
                },
              ),
              SizedBox(
                height: height*.01,
              ),
              SizedBox(
                height: height*.01,
              ),
              SizedBox(
                height: height*.01,
              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  GestureDetector(
//                    onTap: PickImage,
//                    child: CircleAvatar(
//                      radius: 50,
//                      backgroundImage: _image==null ? null : FileImage(_image),
//
//                    ),
//                  ),
//                  Icon(Icons.camera_alt),
//                ],
//              ),
              SizedBox(
                height: height*.01,
              ),
              Builder(
                builder: (context) => Roundedbuttons(title: 'Edit product',coluer: Ktextfieldcolor,
                  onPressed: (){
                  try{
                    if(_globalkey.currentState.validate()){
                      _globalkey.currentState.save();
                      _store.updateproducts((
                     {
                       KproductName: _name,
                       KproductPrice: _price,
                       KproductCategory: _category,
                       KproductDescription: _description,
                     }
                      ), products.documentid);

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Uploaded Succeffully'),
                      ));

                    }
                  }catch(es){
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(es.message),
                    ));
                  }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
