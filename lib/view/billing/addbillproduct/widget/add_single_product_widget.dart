import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import '../../../../core/sizing.dart';
import '../../../../model/prouct_model.dart/product_model.dart';

class AddProductSingleWidget extends StatelessWidget {
  AddProductSingleWidget({super.key, required this.billProductData});
  BillProductModel billProductData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 250,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          kWidth10,
          SizedBox(
            width: 140,
           
            child: Text(billProductData.productName,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        
          SizedBox(
             width: 40,
            child: Text(
              billProductData.amount,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
      SizedBox(
             width: 40,
            child: Text(
            billProductData.qty,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),),
          SizedBox(
             width: 40,
            child: Text(
          
            billProductData.discount,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),),
          SizedBox(
             width: 40,
            child: Text(
            billProductData.totalAmount,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),),
          IconButton(
            onPressed: () {
              Provider.of<AddProductToBillNotif>(context,listen: false).removeTobill(context,billProductData.key);
            },
            icon: const Icon(
              Icons.remove_circle,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
