import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({super.key, required this.hintText, this.prefixIcon});

  final String hintText;
  final Widget? prefixIcon;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.sp).copyWith(bottom: 18.sp),
      height: 28.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.sp),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.02),
            blurRadius: 8,
            spreadRadius: 10,
            offset: const Offset(0, 2)
          )
        ]
      ),
      child: TextFormField(
        cursorColor: greyblueDrkDrk,
        cursorHeight: 20  .sp,
        autofocus: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: white,
          // prefixIcon: widget.prefixIcon ?? const SizedBox(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.sp),
            borderSide: BorderSide.none,
          ),
          hintText: widget.hintText,
          hintStyle: midTextStyle.copyWith(color: greyblueDrkDrk)
        ),
      )
    );
  }
}