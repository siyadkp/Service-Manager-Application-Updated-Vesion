import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_new_call_provider/add_new_call_provide.dart';
import '../../../core/colors.dart';
import '../../../core/sizing.dart';

class ServicallViewSingleWidget extends StatefulWidget {
  const ServicallViewSingleWidget({super.key, required this.serviceCallData});

  final QueryDocumentSnapshot? serviceCallData;

  @override
  State<ServicallViewSingleWidget> createState() =>
      _ServicallViewSingleWidgetState();
}

class _ServicallViewSingleWidgetState extends State<ServicallViewSingleWidget> {
  int colorvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Container(
        height: 110,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            kWidth10,
            Text(widget.serviceCallData?.get('jobnumber'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            kWidth20,
            SizedBox(
              width: 233,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.serviceCallData?.get('customer'),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.serviceCallData?.get('product'),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.serviceCallData?.get('date'),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Consumer<AddNewServiceCallNotifier>(
              builder: (context, serviceCallAddingWidget, child) {
                String value = widget.serviceCallData?.get('status');
                if (value == 'Estimate') {
                  colorvalue = 1;
                } else if (value == 'Complete') {
                  colorvalue = 2;
                } else if (value == 'Delivery') {
                  colorvalue = 3;
                }
                return Container(
                  width: 72.4,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: KColors.statusColor[colorvalue],
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Center(
                    child: Text(
                      widget.serviceCallData?.get('status'),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
