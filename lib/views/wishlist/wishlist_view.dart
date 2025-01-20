import 'package:findmyguide/constants/url_constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.sp,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.sp),
                child: Text("Wishlist", style: titleStyle,),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 18.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(dummyImg, fit: BoxFit.cover, height: 40.sp, width: 28.w,),
                    ),
                    SizedBox(
                      width: 12.sp,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("3 hour Thamel market & temples excursion", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
                          Text("\$ 50 / per", style: smallTextStyle,),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
