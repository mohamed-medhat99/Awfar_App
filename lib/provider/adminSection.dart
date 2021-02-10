import 'package:flutter/cupertino.dart';

class AdminSection extends ChangeNotifier
{

  bool isAdmin = false ;

  changeisAdmin (bool value) {

    isAdmin = value ;
    notifyListeners();
  }

}