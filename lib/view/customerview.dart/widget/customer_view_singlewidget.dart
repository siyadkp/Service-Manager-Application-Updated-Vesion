import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/sizing.dart';

class CustomerViewSingleWidget extends StatelessWidget {
 CustomerViewSingleWidget({
    super.key,
    required this.customerData
  });

QueryDocumentSnapshot? customerData;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: 80,
        width: 250,
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(15),),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(customerData?.get('firstName'),
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600),),
            kWidth20,
            Text(
              customerData?.get('phone'),
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            kWidth20,
            Text(
              customerData?.get('place'),
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            
           
          ],
        ),
      ),
    );
  }
}
