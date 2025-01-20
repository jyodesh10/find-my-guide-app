

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';
import '../widgets/loading_widgets.dart';

loadingDialog() {
  Get.dialog(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 40.h),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const LoadingGif(),
    ),
    barrierDismissible: false,
    transitionCurve: Curves.fastOutSlowIn
  );
}

customsnackBar({required String message, Color? backgroundColor}) {
  Get.snackbar(
    "", 
    "",
    animationDuration: const Duration(milliseconds: 400),
    backgroundColor: backgroundColor ?? white.withOpacity(0.2),
    titleText: Text(message, style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
    messageText: const SizedBox(),
    borderRadius: 16,
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp)
  );
}