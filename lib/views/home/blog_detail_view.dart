import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/constants/url_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';

class BlogDetailView extends StatefulWidget {
  const BlogDetailView({super.key});

  @override
  State<BlogDetailView> createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.sp,
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: black,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 15.sp),
              child: Text("11 Unforgettable Experiences that Await in Guatemala", style: titleStyle,),
            ),
            Center(child: SizedBox(height: 60.sp, child: Image.network(dummyImg1))),
            ListTile(
              leading: CircleAvatar(
                radius: 18.sp,
              ),
              title: Text("Ram Pukar", style: midTextStyle,),
              subtitle: Text(
                "06 July 2024",
                style: smallTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 13.sp, color: greyblueDrkDrk),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.sp).copyWith(bottom: 15.sp),
              child: Text(
                """Adventure is out there…in Guatemala! Even though it is one of the most underrated countries to visit, Guatemala is a treasure trove of experiences for curious adventurers, and not just of the adrenaline-pumping sort.""",
                style: smallTextStyle,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ),
    );
  }

}
