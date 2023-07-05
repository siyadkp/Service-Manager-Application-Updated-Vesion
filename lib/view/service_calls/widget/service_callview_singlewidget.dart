import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';
import '../../../core/sizing.dart';

class ServicallViewSingleWidget extends StatefulWidget {
 ServicallViewSingleWidget({
    super.key,
    required this.serviceCallData
  });

  QueryDocumentSnapshot? serviceCallData;

  @override
  State<ServicallViewSingleWidget> createState() => _ServicallViewSingleWidgetState();
}

class _ServicallViewSingleWidgetState extends State<ServicallViewSingleWidget> {
int colorvalue=0;
@override
  void initState() {
  String value=  widget.serviceCallData?.get('status');
   if(value=='Estimate'){
      colorvalue=1;
   }else if(value=='Complete'){
    colorvalue=2;
   }else if(value=='Delivery'){
colorvalue=3;
   }
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Card(
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child:  Row(
          children: [
            kWidth10,
            Text(widget.serviceCallData?.get('jobnumber'), 
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            kWidth20,
            Container(
              width:244 ,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.serviceCallData?.get('customer'),
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                   Text(
                 widget.serviceCallData?.get('product'), 
                style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              
              Text(
                widget.serviceCallData?.get('date'), 
                style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
                ],
              ),
            ),
          
            Container(
              
              width: 72.4,
              height: double.infinity,
               decoration: BoxDecoration(color:statusColor[colorvalue],borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15))),
               child: Center(
                 child: Text(
                            widget.serviceCallData?.get('status'), 
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
