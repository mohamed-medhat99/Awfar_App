import 'package:awfarapp/Models/product.dart';
import 'package:awfarapp/constants.dart';
import 'package:awfarapp/services/fire_store.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String documentid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder(
        stream: _store.loadOrdersDetails(documentid),
        builder: (context , snapshot){
          if(snapshot.hasData){
             List <Product> product = [];
                 for(var doc in snapshot.data.documents)
                   {
                     product.add(Product(
                       pName: doc.data[KproductName],
                       pquantity: doc.data[KproductQuantity],
                       pPrice: doc.data[KproductCategory],
                     ));
                   }
                 return Column(
                   children: <Widget>[
                     Expanded(
                       child: ListView.builder(
                         itemBuilder: (context , index)=> Padding(
                           padding: const EdgeInsets.all(20),
                           child: Container(
                             height: MediaQuery.of(context).size.height * .2,
                             color: Klogincolor,
                             child: Padding(
                               padding: const EdgeInsets.all(10),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: <Widget>[
                                   Text(
                                     'product name : ${product[index].pName}',
                                     style: TextStyle(
                                         fontSize: 18, fontWeight: FontWeight.bold),
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Text('Total Quantity : ${product[index].pquantity}',
                                       style: TextStyle(
                                           fontSize: 18, fontWeight: FontWeight.bold)),
                                   SizedBox(
                                     height: 10,
                                   ),
                                   Text(
                                     'category is : ${product[index].pCategory}',
                                     style: TextStyle(
                                         fontSize: 18, fontWeight: FontWeight.bold),
                                   ),
                                   SizedBox(
                                     height: 10,
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),
                         itemCount: product.length,

                       ),
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         RaisedButton(
                           onPressed: (){},
                           child: Row(
                             children: <Widget>[
                               Text('confirm'),
                               Icon(Icons.done),
                             ],
                           ),
                           color: Colors.green,
                           textColor: Colors.white,
                         ),
                         RaisedButton(
                           onPressed: (){},
                           child: Row(
                             children: <Widget>[
                               Text('Delete'),
                               Icon(
                                 Icons.clear,
                               ),
                             ],
                           ),
                           color: Colors.red,
                           textColor: Colors.white,
                         ),
                       ],
                     ),
                   ],
                 );
          }
          else
            {
            return Center(child: Text('loading order details'),);
          }

        },
      ),
    );
  }
}
