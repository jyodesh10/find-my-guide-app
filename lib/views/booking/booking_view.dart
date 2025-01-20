import 'package:findmyguide/constants/url_constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
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
                child: Text("Bookings", style: titleStyle,),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 18.sp),
                color: white,
                elevation: 10,
                shadowColor: black.withOpacity(0.2),
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
                          Text("Jan 20, 2025 at 11:00 A.M.", style: smallTextStyle,),
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
