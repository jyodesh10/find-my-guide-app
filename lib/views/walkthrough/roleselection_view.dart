

import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/constants/image_constants.dart';
import 'package:findmyguide/views/walkthrough/walkthrough_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RoleSelectionView extends StatefulWidget {
  const RoleSelectionView({super.key});

  @override
  State<RoleSelectionView> createState() => _RoleSelectionViewState();
}

class _RoleSelectionViewState extends State<RoleSelectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 30.h,
              color: greyblue,
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("GET STARTED", style: titleStyle.copyWith(
                    color: blue,
                    fontWeight: FontWeight.w900,
                    fontSize: 25.sp
                  )),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Text("Welcome", style: titleStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp
                  )),
                  RichText(
                    text: TextSpan(
                      text: "To",
                      style: titleStyle.copyWith(
                        fontSize: 20.sp
                      ),
                      children: [
                        TextSpan(
                          text: "  FindMeAGuide",
                          style: titleStyle.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 22.sp,
                          color: blue
                          )
                        )
                      ]
                    )
                  )
                  // Text("To FindMeAGuide", style: titleStyle),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align( 
                      alignment: Alignment.centerLeft,
                      child: Text("First of all,", style: midTextStyle,)),
                    Text("Are you a", style: titleStyle,),
                    SizedBox(
                      height: 20.sp,
                    ),
                    MaterialButton(
                      onPressed: () {
                        afterRoleNav("tourist");
                      },
                      padding: EdgeInsets.all(15.sp),
                      minWidth: 45.sp,
                      color: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          Image.asset(tourist, color: white,  height: 30.sp,),
                          SizedBox(
                            height: 12.sp,
                          ),
                          Text("Tourist", style: midTextStyle.copyWith(color: white),),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 15.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            color: black.withOpacity(0.6),
                            width: 40.sp,
                          ),
                          Text("   or   ", style: subtitleStyle,),
                          Container(
                            height: 1,
                            color: black.withOpacity(0.6),
                            width: 40.sp,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        afterRoleNav("guide");
                      },
                      padding: EdgeInsets.all(15.sp),
                      minWidth: 45.sp,
                      color: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        children: [
                          Image.asset(guide, color: white,  height: 30.sp,),
                          SizedBox(
                            height: 12.sp,
                          ),
                          Text("Guide", style: midTextStyle.copyWith(color: white),),
                        ],
                      ),
                    ),
                  ],
                ), 
              )
            )
          ],
        ),
      ),
    );
  }

  afterRoleNav(String userRole) {
    Get.to(() => const WalkthroughView());
  }
}