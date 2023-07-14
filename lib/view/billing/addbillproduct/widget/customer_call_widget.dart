import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/model/prouct_model.dart/product_model.dart';
import '../../../../controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import '../../../../core/colors.dart';
import '../../../../core/sizing.dart';

class CustomerCallWidget extends StatefulWidget {
  CustomerCallWidget({super.key, required this.callData});
  QueryDocumentSnapshot<Object?>? callData;
  @override
  State<CustomerCallWidget> createState() => _CustomerCallWidgetState();
}

class _CustomerCallWidgetState extends State<CustomerCallWidget> {
  bool values = false;

  @override
  Widget build(BuildContext context) {
    AddProductToBillNotif addProductToBillNotifObj =
        Provider.of<AddProductToBillNotif>(context, listen: false);
    return Container(
      height: 100,
      width: 390,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Row(
          children: [
            Checkbox(
              value: values,
              onChanged: (value) => setState(() {
                if (value!) {
                  BillProductModel billProduct = BillProductModel(
                    productName: widget.callData?.get('product'),
                    qty: '1',
                    discount:'0',
                    amount: widget.callData?.get('amount') ,
                    totalAmount: widget.callData?.get('amount'),
                  );
                  addProductToBillNotifObj.addTobill(context,
                      billProduct, widget.callData?.get('jobnumber'));
                } else {
                  addProductToBillNotifObj
                      .removeTobill(context,widget.callData?.get('jobnumber'));
                }
                values = value;
              },),
            ),
            Text(widget.callData?.get('jobnumber'),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            kWidth20,
            SizedBox(
              width: 206,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.callData?.get('customer'),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.callData?.get('product'),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.callData?.get('date'),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              width: 72.4,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: KColors.statusColor[3],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Center(
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
