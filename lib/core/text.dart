import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
   ErrorTextWidget({super.key,required this.errorText});
String errorText;
  @override
  Widget build(BuildContext context) {
    return Text(errorText,style: const TextStyle(color: Colors.red),);
  }
}