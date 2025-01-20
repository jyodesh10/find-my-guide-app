import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:findmyguide/constants/font_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../widgets/review_card.dart';

class GuideDetailView extends StatefulWidget {
  const GuideDetailView({super.key});

  @override
  State<GuideDetailView> createState() => _GuideDetailViewState();
}

class _GuideDetailViewState extends State<GuideDetailView> {
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
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: black,
                ),
              ),
              topSection(),
              bioSection(),
              languageAndSpecializationSection(),
              contactSection(),
              reviewSection()
            ],
          ),
        )
      ),
      bottomNavigationBar: Container(
        height: 35.sp,
        color: white,
        child: Row(
          children: [
            SizedBox(
              width: 18.sp,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price",
                  style: midTextStyle,
                ),
                Text(
                  "12\$ / hour",
                  style: titleStyle,
                )
              ],
            ),
            const Spacer(),
            MaterialButton(
              color: blue,
              height: 28.sp,
              minWidth: 38.w,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
              child: Text("Hire Now", style: midTextStyle.copyWith(color: white),),
              onPressed: () {}),
            SizedBox(
              width: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
  
  topSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20.sp,
        ),
        Container(
          height: 52.sp,
          width: 45.sp,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 16.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              border: Border.all(
                color: white,
                width: 6
              ),
              image: const DecorationImage(
                  image: NetworkImage(
                      "https://raw.githubusercontent.com/jyodesh10/find-my-guide/04050359b7c8a0a13ad9a573f8590401b12532e3/uploads/1736433007495.JPG"),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 15.sp,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Ram Pukar", style: titleStyle,),
              Text("kathmandu, Nepal", style: midTextStyle,),
              Text("Since 2002", style: midTextStyle,),
              SizedBox(
                height: 12.sp,
              ),
              Row(
                children: [
                  Container(
                    height: 20.sp,
                    // width: 26.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.sp),
                      border: Border.all(color: green, width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 6.sp,
                        ),
                        CircleAvatar(
                          radius: 12.sp,
                          backgroundColor: green,
                          child: Icon(Icons.check, color: white, size: 15.sp,),
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Text("Verified", style: smallTextStyle.copyWith(color: green, fontWeight: FontWeight.bold),),
                        SizedBox(
                          width: 10.sp,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.sp,
                  ),
                  const Icon(Icons.document_scanner_rounded, color: blue,)
                ],
              ),
              SizedBox(
                height: 12.sp,
              ),
              RatingBar.readOnly(
                filledIcon: Icons.star_rounded, 
                emptyIcon: Icons.star_border_rounded,
                size: 20.sp,
                initialRating: 4,
                maxRating: 5,
              ),
            ],
          ),
        )
      ],
    );
  }
  
  bioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Bio", style: titleStyle.copyWith(fontSize: 16.sp),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Text(
            """Adventure is out there…in Guatemala! Even though it is one of the most underrated countries to visit, Guatemala is a treasure trove of experiences for curious adventurers, and not just of the adrenaline-pumping sort.""",
            style: smallTextStyle,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
  
  languageAndSpecializationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Languages", style: titleStyle.copyWith(fontSize: 16.sp),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Wrap(
            children: [
              Chip(
                label: Text("English", style: subtitleStyle,),
                backgroundColor: greyblue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
                side: const BorderSide(style: BorderStyle.none),
              )
            ],
          )
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Specializations", style: titleStyle,),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Wrap(
            children: [
              Chip(
                label: Text("History", style: subtitleStyle,),
                backgroundColor: greyblue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
                side: const BorderSide(style: BorderStyle.none),
              )
            ],
          )
        )
      ],
    );
  }

  contactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Contacts", style: titleStyle.copyWith(fontSize: 16.sp),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Email", style: subtitleStyle,),
                  SelectableText("Rampukar@gmail.com", style: subtitleStyle.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
              Divider(
                color: black.withOpacity(0.1),
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Phone", style: subtitleStyle,),
                  SelectableText("+977 9813504214", style: subtitleStyle.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
              Divider(
                color: black.withOpacity(0.1),
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Website", style: subtitleStyle,),
                  SelectableText("www.rampukar.com", style: subtitleStyle.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
              Divider(
                color: black.withOpacity(0.1),
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Facebook", style: subtitleStyle,),
                  SelectableText("www.Fb.com", style: subtitleStyle.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
  
  reviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Reviews", style: titleStyle.copyWith(fontSize: 16.sp),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: const Column(
            children: [
              ReviewCard(),
              ReviewCard(),
            ],
          ),
        )
      ],
    );
  }

}
