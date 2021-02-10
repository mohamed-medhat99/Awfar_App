import 'package:awfarapp/constants.dart';
import 'package:awfarapp/provider/adminSection.dart';
import 'package:awfarapp/provider/cartitems.dart';
import 'package:awfarapp/screen/LoginScreen.dart';
import 'package:awfarapp/screen/user/Homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awfarapp/screen/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/modalHud.dart';
import 'package:awfarapp/screen/Admin/AdminHome.dart';
import 'package:awfarapp/screen/Admin/add_product.dart';
import 'package:awfarapp/screen/Admin/Manage_products.dart';
import 'package:awfarapp/screen/Admin/Edit_products.dart';
import 'screen/user/productinfo.dart';
import 'package:awfarapp/screen/user/cartscreen.dart';
import 'package:awfarapp/screen/Admin/OrdersScreen.dart';
import 'package:awfarapp/screen/Admin/orderDetails.dart';

main() =>runApp(MyMpp());

class MyMpp extends StatelessWidget {
  bool isUserLoggedin = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences> (
      future: SharedPreferences.getInstance(),
      builder: (context , snapshot){
        if(!snapshot.hasData){
          return MaterialApp(home: Scaffold(body: Center(child: Text('loading'),),),);
        }
        else{
             isUserLoggedin =  snapshot.data.getBool(Kkey)?? false ;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModalHud>(
                create: (context) => ModalHud(),),
              ChangeNotifierProvider<CartItems>(
                create: (context) => CartItems(),),
              ChangeNotifierProvider<AdminSection>(
                create: (context) => AdminSection(),)
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedin ? HomePage.id : LoginScreen.id,

              routes: {
                LoginScreen.id : (context)=>LoginScreen(),
                SignUpScreen.id : (context)=>SignUpScreen(),
                HomePage.id : (context)=>HomePage(),
                AdminHome.id :(context)=>AdminHome(),
                AddProduct.id : (context)=>AddProduct(),
                ManageProducts.id : (context)=>ManageProducts(),
                EditProducts.id : (context)=>EditProducts(),
                ProductInfo.id : (context)=>ProductInfo(),
                CartScreen.id : (context)=>CartScreen(),
                OrdersScreen.id : (context)=> OrdersScreen(),
                OrderDetails.id : (context)=> OrderDetails(),
              },
            ),
          );

        }
      }
    );

  }
}
