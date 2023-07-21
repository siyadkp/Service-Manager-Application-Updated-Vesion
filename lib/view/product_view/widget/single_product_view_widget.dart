import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/admin_add_product/admin_add_product_provider.dart';

class SingleProductViewWidget extends StatelessWidget {
  SingleProductViewWidget({super.key, required this.productData});

  QueryDocumentSnapshot? productData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black)),
              child: productData?.get('photo') == ''
                  ? Image.asset(
                      'asset/photo-gallery.png',
                      fit: BoxFit.cover,
                    )
                  : Image.network(productData!.get('photo'), fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 195,
                          child: Text(
                            productData!.get('productName'),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          )),
                          IconButton(onPressed: (){
                                 showDialog(
                        context: context,
                        builder: (BuildContext ctx) => AlertDialog(
                          title: const Text('Warning'),
                          content: const Text(
                             "Are you sure you want to delete this product?"),
                             
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () async {
                              Provider.of<AdminAddProductNotifier>(context,listen: false).deleteProduct(productData!.id);
                                 Navigator.pop(ctx);
                              },
                            ),
                          ],
                        ),
                      );
                          }, icon:const Icon(Icons.delete,color: Colors.red,),)
                    ],
                  ),
                
                  Text(
                    '₹ ${productData!.get('retailPrice')}',
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                 
                  Text(
                    'Qty : ${productData!.get('qty')}',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
