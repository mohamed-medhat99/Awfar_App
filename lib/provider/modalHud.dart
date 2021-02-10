
import 'package:flutter/cupertino.dart';

class ModalHud extends ChangeNotifier{
  bool isLoading = false;


  changeisLoading (value){

    isLoading = value ;
    notifyListeners();
  }

}