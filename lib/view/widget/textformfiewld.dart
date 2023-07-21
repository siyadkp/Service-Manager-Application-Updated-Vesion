import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/admin_add_product/admin_add_product_provider.dart';
import 'package:service_manager/core/colors.dart';
import '../../core/naming.dart';

class TopTextTextFormFieldWidget extends StatefulWidget {
  TopTextTextFormFieldWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.controllerObj,
      required this.screenName,
      this.controllerIndex,
      this.maxLines = 1,
      this.paddingtop = 15,
      this.paddingRight=0,
      this.fontsize = 15,
      this.condition = false,
      this.hintText = '',
      this.keyboardType = TextInputType.name});
  double width;
  double height;
  double paddingtop;
  double paddingRight;
  double fontsize;
  int maxLines;
  int? controllerIndex;
  String text;
  String hintText;
  String screenName;
  bool condition;
  TextEditingController controllerObj;
  TextInputType keyboardType;

  @override
  State<TopTextTextFormFieldWidget> createState() =>
      _TopTextTextFormFieldWidgetState();
}

class _TopTextTextFormFieldWidgetState
    extends State<TopTextTextFormFieldWidget> {
  String textFormFielError = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.paddingtop,right: widget.paddingRight),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                bottom: 5,
              ),
              child: Text(
                widget.text,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: widget.fontsize),
              ),
            ),
            Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color:KColors.clrGrey)),
              child: widget.condition
                  ? TextFormField(
                      controller: widget.controllerObj,
                      keyboardType: widget.keyboardType,
                      maxLines: 9,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Please enter ${widget.text}",
                          filled: true),
                      onChanged: (value) {
                        if (widget.screenName == allScreenNames[1] &&
                            widget.controllerIndex != null) {
                        }
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: widget.controllerObj,
                        keyboardType: widget.keyboardType,
                        decoration: InputDecoration(
                            hintText: "Please enter ${widget.text}",
                            border: InputBorder.none),
                        onChanged: (value) {
                          if (widget.screenName == allScreenNames[0]) {
                            if (widget.controllerIndex! < 5) {
                              Provider.of<AdminAddProductNotifier>(context,
                                      listen: false)
                                  .totalPriceCalculating();
                            }
                          } 
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


