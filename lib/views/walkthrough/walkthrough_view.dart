

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/walkthrough_controller.dart';
import 'package:findmyguide/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WalkthroughView extends StatefulWidget {
  const WalkthroughView({super.key});

  @override
  State<WalkthroughView> createState() => _WalkthroughViewState();
}

class _WalkthroughViewState extends State<WalkthroughView> {

  final controller = Get.put(WalkthroughController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 28.h,
                  color: greyblue,
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("FindMeAGuide", style: titleStyle.copyWith(
                        color: blue,
                        fontWeight: FontWeight.w900,
                        fontSize: 25.sp
                      )),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Text("Introduction Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel blandit augue, at elementum dui. Aenean vel blandit augue, at elementum dui.. Aenean vel blandit augue, at elementum dui.", style: subtitleStyle.copyWith(                  )),
                      // RichText(
                      //   text: TextSpan(
                      //     text: "To",
                      //     style: titleStyle.copyWith(
                      //       fontSize: 20.sp
                      //     ),
                      //     children: [
                      //       TextSpan(
                      //         text: "  FindMeAGuide",
                      //         style: titleStyle.copyWith(
                      //         fontWeight: FontWeight.w900,
                      //         fontSize: 22.sp,
                      //         color: blue
                      //         )
                      //       )
                      //     ]
                      //   )
                      // )
                      // Text("To FindMeAGuide", style: titleStyle),
                    ],
                  ),
                ),
                Expanded(
                  child: CarouselSlider(
                    items: [
                      Container(
                        color: greyblueDrkDrk,
                      ),
                      Container(
                        color: greyblueDrk,
                      ),
                      Container(
                        color: greyblue,
                      ),
                    ], 
                    options: CarouselOptions(
                      height: double.infinity,
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        controller.dotIndex.value = index;
                        
                      },
                    )
                  )
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Obx(() =>
                      DotsIndicator(
                        dotsCount: 3,
                        position: controller.dotIndex.value,
                        decorator: const DotsDecorator(
                          activeColor: blue,
                          color: greyblue
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Obx(() =>
                    MaterialButton(
                      onPressed: () {
                        if(controller.dotIndex.value < 2) {
                          controller.dotIndex.value = controller.dotIndex.value + 1;
                        }
                        if(controller.dotIndex.value==2) {
                          Get.offAll(() => const LoginView());
                        }
                      },
                      color: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 25.sp),
                      child: Text(controller.dotIndex.value==2 ? "Sign in" : "Next", style: titleStyle.copyWith(color: white),),
                    ),
                  ),
                  Obx(() => controller.dotIndex.value == 2
                    ? SizedBox(
                      height: 28.sp,
                    )
                    : TextButton(
                      onPressed: () {
                        controller.dotIndex.value = 2;  
                      }, 
                      style: const ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(greyblue)
                      ),
                      child: Text("Skip", style: midTextStyle.copyWith(color: blue),)
                    ),
                  )
                ],
              ), 
            ),
          ],
        ),
      ),
    );
  }
}