


import 'package:findmyguide/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constants.dart';

customAppbar({String? title, bool? hasLeading = true}) {
  return AppBar(
    backgroundColor: primaryClr,
    leading: hasLeading == true 
    ? IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(
        Icons.arrow_back_rounded,
        color: black,
      ),
    )
    : null,
    title: Text(title!, style: titleStyle),
  );
}