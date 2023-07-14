import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/sizing.dart';
import '../../../../model/prouct_model.dart/product_model.dart';

class AddProductSingleWidget extends StatelessWidget {
  AddProductSingleWidget({super.key, required this.billProductData});
  BillProductModel? billProductData;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(202, 226, 232, 100),
      child: Container(
        height: 60,
        width: 250,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(billProductData!.productName,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            kWidth10,
            Text(
              billProductData!.amount,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              billProductData!.qty,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              billProductData!.discount,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              billProductData!.totalAmount,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
