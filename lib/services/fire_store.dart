import 'package:awfarapp/Models/orders.dart';
import 'package:awfarapp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awfarapp/Models/product.dart';
import 'package:flutter/foundation.dart';
class Store {

  final Firestore _firestore = Firestore.instance;

  addProduct(Product product) async {
    await _firestore.collection(KproductCollection).add({

      KproductName: product.pName,
      KproductPrice: product.pPrice,
      KproductCategory: product.pCategory,
      KproductDescription: product.pDescription,
      Kproductimage: product.purl,

    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(KproductCollection).snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(KproductCollection).document(documentId).delete();
  }

  updateproducts(data, documentID) {
    _firestore.collection(KproductCollection).document(documentID).updateData(
        data);
  }

  addOrderss(data, List<Product> products ) {
    var documentref = _firestore.collection(Korders).document();
    documentref.setData(data);
    for (var product in products) {
      documentref.collection(KorderDetails).document().setData(
          {

            KproductName: product.pName,
            KproductPrice: product.pPrice,
            KproductQuantity: product.pquantity,
            Kproductimage: product.purl,
            KproductCategory : product.pCategory,

          });
    }
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(Korders).snapshots();
  }
  Stream<QuerySnapshot> loadOrdersDetails(documentid) {
    return _firestore.collection(Korders).document(documentid).collection(KorderDetails).snapshots();
  }
}
