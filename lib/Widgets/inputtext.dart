import 'package:flutter/material.dart';
import 'package:awfarapp/constants.dart';
class TextFields extends StatelessWidget {

  TextFields({ @required this.OnClick , this.icoon , @required this.hinttext});

  final IconData icoon;

  final String hinttext;

  String _ErrorMessage (String str){
    switch(hinttext)
    {
      case 'Enter your Name' : return 'please enter your name';
      case 'Enter your Email' : return 'please enter your E-mail';
      case 'Enter your Password' : return 'please enter your password';
    }
  }
  final Function OnClick ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        validator: (value)
        {
          if(value.isEmpty){
            return _ErrorMessage(hinttext);
          }

        },
        onSaved: OnClick,
        obscureText: hinttext == 'Enter your Password' ? true : false ,
        decoration: InputDecoration(
          filled: true,
          fillColor: Ktextfieldcolor,
          prefixIcon: Icon(
            icoon,
            color: Colors.black,
          ),
          hintText: hinttext,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
