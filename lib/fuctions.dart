

import 'package:flutter/material.dart';

import 'Models/product.dart';

List<Product> getproductbyCategory(Kjackets , List<Product> allproducts) {
  List<Product> products =[];
  try{
    for(var product in allproducts){
      if(product.pCategory == Kjackets){
        products.add(product);
      }
    }
  }on Error catch(ex){
    print(ex);
  }
  return products;
}