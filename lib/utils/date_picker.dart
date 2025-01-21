


import 'package:flutter/material.dart';

import 'date_formatter.dart';

Future<String?> customDatePicker (BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context, 
    firstDate: DateTime(1940), 
    lastDate: DateTime.now()
  );
  if(pickedDate.toString()!="null") {
    return DateTimeFormatter.formatDate(pickedDate.toString());
  } else {
    return "";
  }
}