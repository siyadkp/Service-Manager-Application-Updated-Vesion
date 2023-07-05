import 'package:flutter/material.dart';
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
      this.hintText = '',this.keyboardType=TextInputType.name});
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
          Padding(
            padding: const EdgeInsets.only(bottom: 5, right: 10),
            child: Text(text,
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: fontsize)),
          ),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(15)),
            child: condition
                ? TextField(
                  controller:controllerObj ,
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
                        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color:clrGrey, width: 2.0),
          ),
                          border: OutlineInputBorder(),
                        filled: true),
                    onChanged: (value) {
                      if (controllerListName == 'addProductControlerList') {
                        // addProductControlerList[controllerIndex!];
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
