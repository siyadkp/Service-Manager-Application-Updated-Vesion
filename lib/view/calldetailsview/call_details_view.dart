import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_manager/core/sizing.dart';
import 'package:service_manager/view/callstatusupdation/call_status_updation.dart';

import '../../core/colors.dart';

class ScreenCallDetailView extends StatelessWidget {
ScreenCallDetailView({super.key,required this.serviceCallData});
QueryDocumentSnapshot? serviceCallData;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 30,left: 15),
          child: Column(
            children: [
              Align(alignment: Alignment.topLeft, child: InkWell(onTap: () {
                Navigator.pop(context);
              }, child: Container(width: 40,height: 40,color: clrDarkBlue,child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),))),
               const Text(
                'Call Details',
                style: TextStyle(fontSize: 25),
              ),
           
              TextWIdget(text1: 'Coustomer:', text2: 'Sahil Saleem'),
              TextWIdget(
                  text1: 'Product Category:',
                  text2: 'Printer',
                  textsize1: 20,
                  textsize2: 17),
              TextWIdget(
                  text1: 'Product:',
                  text2: 'Canon LBP 2900',
                  textsize1: 20,
                  textsize2: 17),
              TextWIdget(
                  text1: 'Complaint:',
                  text2: 'Not Working',
                  textsize1: 20,
                  textsize2: 17),
              TextWIdget(
                  text1: 'Serail No:',
                  text2: 'SN8793N3456',
                  textsize1: 20,
                  textsize2: 17),
              TextWIdget(
                  text1: 'Date:',
                  text2: 'Apr 22/2023',
                  textsize1: 20,
                  textsize2: 17),
              TextWIdget(
                  text1: 'Status:',
                  text2: 'Complete',
                  textsize1: 20,
                  textsize2: 17),
              TextWIdget(
                  text1: 'Type:',
                  text2: 'Carry In',
                  textsize1: 20,
                  textsize2: 17),
              kHeight20,
              Container(
                  width: 360,
                  child: Text(
                    'Description :',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  )),
              const Text(
                'This have fuser and picup eoller issue',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenCallStatusUpdation(),));
                },
                child: const Text('Edit Call Details'),style: ElevatedButton.styleFrom(
                            backgroundColor: clrDarkBlue,
                           
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextWIdget extends StatelessWidget {
  TextWIdget(
      {super.key,
      required this.text1,
      required this.text2,
      this.textsize1 = 24,
      this.textsize2 = 19});

  double textsize1;
  double textsize2;
  String text1;
  String text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 30),
      child: Row(
        children: [
          Text(
            text1,
            style: TextStyle(fontSize: textsize1, color: Colors.grey[600]),
          ),
          Text(
            '  $text2',
            style: TextStyle(fontSize: textsize2),
          )
        ],
      ),
    );
  }
}
