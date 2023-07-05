import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_manager/controller/provider/service_call_status_updation/service_call_status_updation.dart';

import '../../../core/colors.dart';

String? dropdownValue;

class DropdownButtonWidget extends StatefulWidget {
  DropdownButtonWidget(
      {super.key, required this.list, this.width = 73, required this.status});
  List<String> list;
  String status;
  double width;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  void initState() {
    if (widget.status == widget.list[0]) {
      dropdownValue = widget.list[0];
    } else if (widget.status == widget.list[1]) {
      dropdownValue = widget.list[1];
    } else if (widget.status == widget.list[2]) {
      dropdownValue = widget.list[2];
    } else if (widget.status == widget.list[3]) {
      dropdownValue = widget.list[3];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: clrGrey)),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: SizedBox(),
        // elevation: 16,
        // style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 0,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }
}
