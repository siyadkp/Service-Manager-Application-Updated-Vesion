import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/model/prouct_model.dart/product_model.dart';
import '../../../../controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import '../../../../core/colors.dart';
import '../../../../core/sizing.dart';

class CustomerCallWidget extends StatelessWidget {
  CustomerCallWidget({super.key, required this.callData, required this.index});

  final QueryDocumentSnapshot<Object?>? callData;
  final int index;
  bool isAddedToBill = false;

  @override
  Widget build(BuildContext context) {
    AddProductToBillNotif addProductToBillNotifObj =
        Provider.of<AddProductToBillNotif>(context, listen: false);
    return Container(
      height: 100,
      width: 370,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Row(
          children: [
            Consumer<AddProductToBillNotif>(
                builder: (context, addProductToBillNotif, _) {
              return Checkbox(
                  value: isAddedToBill,
                  onChanged: (value) {
                    BillProductModel billProduct = BillProductModel(
                      type: 2,
                      docId: callData!.id,
                      productName: callData?.get('product'),
                      qty: '1',
                      discount: '0',
                      amount: callData?.get('amount'),
                      totalAmount: callData?.get('amount'),
                      key: callData?.get('jobnumber'),
                    );
                    if (value!) {
                      addProductToBillNotifObj.addTobill(
                        context,
                        billProduct,
                        callData?.get('jobnumber'),
                      );
                    } else {
                      addProductToBillNotifObj.removeTobill(
                        context,
                        billProduct,
                        index,
                      );
                    }
                    isAddedToBill = value;
                  });
            }),
            Text(callData?.get('jobnumber'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            kWidth20,
            SizedBox(
              width: 183,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    callData?.get('customer'),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    callData?.get('product'),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    callData?.get('date'),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              width: 80,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: KColors.statusColor[2],
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: const Center(
                child: Text(
                  'complete',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
