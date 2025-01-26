


import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/constants/font_constants.dart';
import 'package:flutter/material.dart';

import 'date_formatter.dart';

Future<String?> customDatePicker (BuildContext context, {DateTime? lastDate}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context, 
    firstDate: DateTime(1940), 
    lastDate: lastDate??DateTime.now(),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: blue, 
              onPrimary: white, 
              surface: greyblue, 
            ),
          datePickerTheme: DatePickerThemeData(
            backgroundColor: white,
            headerBackgroundColor: greyblue,
            // dayForegroundColor:   WidgetStateProperty.all(blue),
            // dayBackgroundColor:   WidgetStateProperty.all(blue),
            dividerColor: greyblue,
            confirmButtonStyle: ButtonStyle(
              textStyle: WidgetStatePropertyAll(midTextStyle.copyWith(fontWeight: FontWeight.bold ,color: greyblueDrkDrk))
            ),
            cancelButtonStyle: ButtonStyle(
              textStyle: WidgetStatePropertyAll(midTextStyle.copyWith(fontWeight: FontWeight.bold ,color: greyblueDrkDrk))
            ),
            yearOverlayColor: WidgetStateProperty.all(greyblue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            dayOverlayColor:  WidgetStateProperty.all(blue),
            todayBorder: const BorderSide(color:greyblue, width: 1.5),
            weekdayStyle: midTextStyle.copyWith(fontWeight: FontWeight.bold, color: blue)
          ),
          
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: blue, // button text color
            ),
          ),
        ),
        child: child!
      );
    },
  );
  if(pickedDate.toString()!="null") {
    return DateTimeFormatter.formatDate(pickedDate.toString());
  } else {
    return "";
  }
}