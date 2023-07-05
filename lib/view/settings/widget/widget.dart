import 'package:flutter/material.dart';

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
        Icon(icon),
        SizedBox(width: 230, child: Text(text,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: lasticon ? Colors.black : Colors.red))),
         const SizedBox(width: 20,),
      ],
      
    );
  }
}