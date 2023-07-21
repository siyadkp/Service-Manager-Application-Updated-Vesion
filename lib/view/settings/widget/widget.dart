import 'package:flutter/material.dart';
import 'package:service_manager/core/colors.dart';

class SettingsWidget extends StatelessWidget {
  SettingsWidget({super.key,required this.icon,required this.text,required this.lasticon});
  IconData icon;
  String text;
bool lasticon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:KColors.clrDarkBlue,), height: 40,width: 40, child: Icon(icon,color: Colors.white,)),
        SizedBox(width: 230, child: Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: lasticon ? Colors.black : Colors.red))),
         const SizedBox(width: 20,),
      ],
      
    );
  }
}