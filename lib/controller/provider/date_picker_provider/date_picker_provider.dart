import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerNotifier extends ChangeNotifier {
  String? formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  datePicker(
    BuildContext context,
  ) async {
    DateTime? selectedDate;
    final selectedDateTemp = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now(),
    );
    if (selectedDateTemp == null) {
      return;
    } else {
      selectedDate = DateTime(
        selectedDateTemp.year,
        selectedDateTemp.month,
        selectedDateTemp.day,
      );
      formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    }

    notifyListeners();
  }
}
