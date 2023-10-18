import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../core/sizing.dart';

class CustomerViewSingleWidget extends StatelessWidget {
  const CustomerViewSingleWidget(
      {super.key, required this.customerData, this.width = 250});

  final QueryDocumentSnapshot? customerData;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              customerData?.get('firstName'),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            kWidth20,
            Text(
              customerData?.get('phone'),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            kWidth20,
            Text(
              customerData?.get('place'),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
