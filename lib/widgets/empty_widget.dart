import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';
import '../constants/image_constants.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(emptybox, height: 45.sp,),
          SizedBox(
            height: 15.sp,
          ),
          Text("Empty wishlist", style: midTextStyle.copyWith(fontWeight: FontWeight.bold, color: black.withOpacity(0.3)),),
          SizedBox(
            height: 40.sp,
          ),
        ],
      )
    );
  }
}