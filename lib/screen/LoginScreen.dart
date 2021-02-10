import 'package:awfarapp/screen/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awfarapp/constants.dart';
import 'package:awfarapp/Widgets/inputtext.dart';
import 'package:awfarapp/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:awfarapp/screen/user/Homepage.dart';
import 'package:awfarapp/provider/modalHud.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:awfarapp/provider/adminSection.dart';
import 'package:awfarapp/screen/Admin/AdminHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LogenScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  final adminPassword = 'admin123456';

  bool keepmesignin = false;

  String _email ;

  String _password ;

  bool isAdmin = false;

  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
          backgroundColor: Klogincolor ,
          body: ModalProgressHUD(
            inAsyncCall: Provider.of<ModalHud>(context).isLoading,
            child: Form(
              key: globalKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top : 40.0),
                    child: Container(
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
                  ),
                  SizedBox(
                    height: height*.1,
                  ),
                  TextFields(icoon: Icons.email, hinttext: 'Enter your Email', OnClick: (value){_email = value ;},),
                  Padding(
                    padding: EdgeInsets.only(left: 15 ,right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Klogincolor,
                          value: keepmesignin,
                          onChanged: (value){
                           setState(() {
                             keepmesignin = value ;
                           });
                          },
                        ),
                        Text('Remember Me',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ],
                    ),
                  ),
                  TextFields(icoon: Icons.vpn_key, hinttext: 'Enter your Password', OnClick: (value){_password = value;}, ),

                  SizedBox(
                    height: height*.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:150.0),
                    child: Builder(
                      builder:(context)=> FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        onPressed: (){
                          if(keepmesignin == true){
                            KeepUserSignin();
                          }
                          _validate(context);
                        },
                        color: Colors.white,
                        child: Text('Login',
                          style: TextStyle(
                            color: Colors.black,

                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height*.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Dont Have An Account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, SignUpScreen.id);
                        },
                        child: Text('SignUp' ,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height*0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          Provider.of<AdminSection>(context , listen: false).changeisAdmin(true);
                        },
                        child: Text('I\'am an Admin',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Provider.of<AdminSection>(context).isAdmin ? Klogincolor : Colors.black
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Provider.of<AdminSection>(context , listen: false).changeisAdmin(false);
                        },
                        child: Text('I\'am a User',
                         style: TextStyle(
                           fontSize: 20.0,
                           fontWeight: FontWeight.bold,
                           color: Provider.of<AdminSection>(context).isAdmin ? Colors.black : Klogincolor
                         ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
    );
  }

  void _validate(BuildContext context) async {
    final modalhud = Provider.of<ModalHud>(context, listen: false);
    modalhud.changeisLoading(true);
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      if (Provider.of<AdminSection>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
            await _auth.signin(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modalhud.changeisLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          modalhud.changeisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong !'),
          ));
        }
      } else {
        try {
          await _auth.signin(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modalhud.changeisLoading(false);
  }

  void KeepUserSignin() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(Kkey, keepmesignin);
  }
}


