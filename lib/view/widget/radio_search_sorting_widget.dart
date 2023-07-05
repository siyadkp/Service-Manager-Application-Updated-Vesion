import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioSearchSortingWidget extends StatelessWidget {
  RadioSearchSortingWidget({super.key, required this.name});

  String name;

  @override
  Widget build(BuildContext context) {
    bool clicked = false;
    return Container(
      width: 100,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 35,
            child: Radio(
              activeColor: const Color.fromARGB(255, 0, 162, 255),
              groupValue: clicked,
              onChanged: (bool? value) {
                clicked = !clicked;
              },
              value: true,
            ),
          ),
          Text(name),
        ],
      ),
    );
  }
}
