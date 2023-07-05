import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_manager/core/colors.dart';
import 'package:service_manager/model/prouct_model.dart/product_model.dart';

import '../../../core/sizing.dart';

class SIngleProductViewWidget extends StatelessWidget {
  SIngleProductViewWidget({
    super.key,
    required this.productData
  });
  QueryDocumentSnapshot? productData;

  @override
  Widget build(BuildContext context) {
    

    return Container(
      
      height: 140,width:double.infinity,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
      child: Card(
        child: Row( children: [
         SizedBox(width: 20,),
          Container(height: 90,width: 100,decoration:BoxDecoration(border: Border.all(width: 1,color: Colors.black)),child:productData!.get('photo')=='' ?Image.asset('asset/photo-gallery.png',fit: BoxFit.cover,):Image.file(File(productData!.get('photo')),fit: BoxFit.cover),),Padding(
            padding: EdgeInsets.only(top: 20,left: 30),
            child:  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(width: 239,height: 40, child: Text(productData!.get('productName'),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),)),SizedBox(height: 10,),Text('₹ ${productData!.get('retailPrice')}',style: TextStyle(fontSize: 15,color: Colors.grey),),Text('Qty : ${productData!.get('qty')}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),),
            ],),
          ),
        ],),
      ),
    );
  }
}