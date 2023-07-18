import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/add_product_to_bill_provider/add_product_to_bill_provider.dart';
import 'package:service_manager/core/colors.dart';

class RightTextTextFormFieldWidget extends StatelessWidget {
  RightTextTextFormFieldWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.controllerObj,
      this.controllerIndex,
      this.controllerListName,
      this.maxLines = 1,
      this.paddingtop = 25,
      this.fontsize = 15,
      this.condition = false,
      this.hintText = '',
      this.keyboardType = TextInputType.name});
  double width;
  double height;
  double paddingtop;
  double fontsize;
  int maxLines;
  int? controllerIndex;
  String text;
  String? controllerListName;
  String hintText;
  bool condition;
  TextEditingController controllerObj;
  TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingtop),
      child: Row(
        children: [
          Text(text,
              style:
                  GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: fontsize)),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: KColors.clrGrey)),
            child: condition
                ? TextField(
                    controller: controllerObj,
                    keyboardType: keyboardType,
                    decoration: const InputDecoration(
                        //labelText: title ,  // you can change this with the top text  like you want
                        hintText: "Please enter your ",
                        border: InputBorder.none,
                        filled: true),
                    onChanged: (value) {
                      if (controllerListName == 'addProductControlerList') {
                        // addProductControlerList[controllerIndex!];
                      }
                    },
                  )
                : TextField(
                    controller: controllerObj,
                    keyboardType: keyboardType,
                    decoration: const InputDecoration(
                        //labelText: title ,  // you can change this with the top text  like you want
                        hintText: "Please enter your ",
                        border: InputBorder.none,
                        filled: true),
                    onChanged: (value) {
                     Provider.of<AddProductToBillNotif>(context,listen: false).productTotalAmount();
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
