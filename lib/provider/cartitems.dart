import 'package:awfarapp/Models/product.dart';
import 'package:flutter/cupertino.dart';

class CartItems extends ChangeNotifier
{
 List <Product> products = [];


 addProducts (Product product){
   products.add(product);
   notifyListeners();
 }

 deleteProduct(Product product){

   products.remove(product);

   notifyListeners();
 }

}