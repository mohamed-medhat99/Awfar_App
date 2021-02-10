import 'dart:io';
import 'package:awfarapp/Models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:awfarapp/constants.dart';
import 'package:awfarapp/Widgets/inputtext.dart';
import 'package:awfarapp/Widgets/rounder_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awfarapp/services/fire_store.dart';
class AddProduct extends StatefulWidget {
  static String id = 'AddProducts';


  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  File _image;
  final _store = Store();
  String _name , _price , _description , _category  , _url;
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: PickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _image==null ? null : FileImage(_image),

                    ),
                  ),
                  Icon(Icons.camera_alt),
                ],
              ),
              Center(
                child: Text(
                  'Add product image',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
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
              Builder(
                builder: (context) => Roundedbuttons(title: 'upload data',coluer: Ktextfieldcolor,
                  onPressed: ()async{
                    await uploadImage(context);
                    if(_globalkey.currentState.validate()){
                      _globalkey.currentState.save();
                      _store.addProduct(Product(
                        pName: _name,
                        pPrice: _price,
                        pCategory: _category,
                        pDescription: _description,
                        purl: _url,

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

  void PickImage() async{
     // ignore: deprecated_member_use
     var image = await ImagePicker.pickImage(source: ImageSource.gallery);
     setState(() {
       _image = image ;
     });
  }

 void uploadImage( context) async{
    try{

    FirebaseStorage storage= FirebaseStorage(storageBucket: 'gs://awfar-9317c.appspot.com');
    StorageReference ref = storage.ref().child(p.basename(_image.path));
    StorageUploadTask upload = ref.putFile(_image);
    StorageTaskSnapshot snapShot = await upload.onComplete;

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text ('uploaded sucessfully'),
    ));

    String retrivedurl = await  snapShot.ref.getDownloadURL();


    setState(() {
      _url = retrivedurl;
      print('UB_url $_url');
    });
    } catch(ex){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text (ex.message),
      ));
    }
  }

}
