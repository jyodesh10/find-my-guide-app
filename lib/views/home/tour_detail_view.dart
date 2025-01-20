import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/constants/url_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../widgets/review_card.dart';

class TourDetailView extends StatefulWidget {
  const TourDetailView({super.key});

  @override
  State<TourDetailView> createState() => _TourDetailViewState();
}

class _TourDetailViewState extends State<TourDetailView> {
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
              Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: black,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outline_rounded,
                      color: pink,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share_rounded,
                      color: black,
                    ),
                  ),
                ],
              ),
              titleImgSection(),
              SizedBox(
                height: 5.sp,
              ),
              highlightSection(),
              SizedBox(
                height: 15.sp,
              ),
              descriptionSection(),
              reviewSection()
            ],
          ),
        ),
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
                  "450\$ / person",
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
              child: Text("Book Now", style: midTextStyle.copyWith(color: white),),
              onPressed: () {}),
            SizedBox(
              width: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  titleImgSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 15.sp),
          child: Text(
            "3 hour Thamel market & temples excursion",
            style: titleStyle,
          ),
        ),
        Center(
          child: SizedBox(
            height: 60.sp,
            width: 90.w,
            child: Image.network(
              dummyImg,
              fit: BoxFit.cover,
            )
          )
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.sp),
          child: Text(
            "Guided by: Ghanshyam",
            style: subtitleStyle,
          ),
        ),
      ],
    );
  }

  highlightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text(
            "Highlights",
            style: titleStyle.copyWith(fontSize: 16.sp),
          ),
        ),
        Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 15.sp,
            spacing: 15.sp,
            children: [
              highlightsTile(
                  icon: Icon(
                    Icons.location_on,
                    size: 19.sp,
                    color: black,
                  ),
                  content: "Kathmandu, Nepal"),
              highlightsTile(
                  icon: Icon(
                    Icons.access_time_filled_rounded,
                    size: 19.sp,
                    color: black,
                  ),
                  content: "8 Hours"),
              highlightsTile(
                  icon: Icon(
                    Icons.language,
                    size: 19.sp,
                    color: black,
                  ),
                  content: "English"),
              highlightsTile(
                  icon: Icon(
                    Icons.info_rounded,
                    size: 19.sp,
                    color: black,
                  ),
                  content: "History, Culture, Food"),
            ],
          ),
        ),
      ],
    );
  }

  highlightsTile({required Icon icon, required String content}) {
    return Container(
      height: 30.sp,
      width: 42.w,
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: greyblue,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17.sp,
            backgroundColor: greyblueDrk,
            child: icon,
          ),
          SizedBox(
            width: 12.sp,
          ),
          Expanded(
              child: Text(
            content,
            style: subtitleStyle.copyWith(height: 4.2.sp),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ))
        ],
      ),
    );
  }
  
  descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text(
            "Description",
            style: titleStyle.copyWith(fontSize: 16.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Text(
            """Explore the daily life of the local people of Kathmandu as you walk through the old roads of Thamel. The streets have lived through the decades and are the most popular tourist destination in Kathmandu. The tour starts from the famous Thamel area through all the famous old parts of Kathmandu.""",
            style: subtitleStyle,
          ),
        ),
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
