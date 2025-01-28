import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({super.key, required this.hintText, this.suffixIcon, this.controller, this.margin, this.validator, this.keyboardType, this.enabled, this.readOnly, this.onTap, this.textInputAction});

  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? margin;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final bool? readOnly;
  final void Function()? onTap;
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(horizontal: 18.sp).copyWith(bottom: 18.sp),
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
        validator: widget.validator,
        cursorColor: greyblueDrkDrk,
        cursorHeight: 20  .sp,
        autofocus: false,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        enabled: widget.enabled,
        readOnly: widget.readOnly ?? false,
        onTap: widget.onTap,
        decoration: InputDecoration(
          filled: true,
          fillColor: white,
          suffixIcon: widget.suffixIcon ?? const SizedBox(),
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