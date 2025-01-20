import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/home_controller.dart';
import 'package:findmyguide/views/home/blog_detail_view.dart';
import 'package:findmyguide/views/home/guide_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/url_constants.dart';
import 'tour_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    fetchall();
  }

  fetchall() async {
    await controller.getToursRequest();
    await controller.getGuidesRequest();
  }

  @override
  Widget build(BuildContext context) {
    // fetchall();
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topSection(),
              searchSection(),
              locationsSection(),
              toursSection(),
              blogsSection(),
              guideSection(),
              SizedBox(
                height: 50.sp,
              )
            ],
          ),
        ),
      ),
    );
  }

  topSection() {
    return SizedBox(
      height: 45.sp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning,\nJyodesh",
                      style: titleStyle.copyWith(
                          fontSize: 17.sp, color: black.withOpacity(0.8)),
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          size: 18.sp,
                          color: green,
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Text(
                          "Kathmandu, Nepal",
                          style: midTextStyle.copyWith(
                              fontSize: 14.sp, color: greyblueDrkDrk),
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: greyblue,
                  radius: 22.sp,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  searchSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.sp).copyWith(bottom: 18.sp),
      height: 28.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.sp),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.02),
            blurRadius: 8,
            spreadRadius: 10,
            offset: const Offset(0, 2)
          )
        ]
      ),
      child: TextFormField(
        cursorColor: greyblueDrkDrk,
        cursorHeight: 20  .sp,
        autofocus: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: white,
          prefixIcon: const Icon(Icons.search,color: greyblueDrkDrk),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.sp),
            borderSide: BorderSide.none,
          ),
          hintText: "Search tours, blogs or guides...",
          hintStyle: midTextStyle.copyWith(color: greyblueDrkDrk)
        ),
      )
    );
  }

  locationsSection() {
    return SizedBox(
      height: 41.sp,
      child: ListView.separated(
        itemCount: 5,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 18.sp),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CircleAvatar(
                radius: 23.sp,
              ),
              SizedBox(
                height: 8.sp,
              ),
              Text("Patan", style: subtitleStyle,)
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 15.sp,
          );
        },
      ),
    );
  }

  toursSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.sp),
          child: Text(
            "Available Tours",
            style: titleStyle,
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        SizedBox(
          height: 65.sp,
          child: ListView.separated(
            itemCount: controller.toursList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 18.sp),
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Get.to(()=> const TourDetailView(), transition: Transition.fade);
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 52.sp,
                          width: 60.w,
                          margin: EdgeInsets.only(bottom: 10.sp),
                          decoration: BoxDecoration(
                              color: greyblue,
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                  image: NetworkImage(index==0 ? dummyImg2 : dummyImg), fit: BoxFit.cover)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12.sp, left: 12.sp),
                          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                          decoration: BoxDecoration(
                            color: greyblue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(controller.toursList[index].highlights!.duration.toString(), style: smallTextStyle,),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35.sp,
                      width: 58.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.toursList[index].title.toString(),
                            style: midTextStyle.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            controller.toursList[index].price.toString(),
                            style: smallTextStyle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 15.sp,
            ),
          ),
        )
      ],
    );
  }

  blogsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.sp),
          child: Text(
            "Blogs",
            style: titleStyle,
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        SizedBox(
          height: 75.sp,
          child: ListView.separated(
            itemCount: controller.toursList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 18.sp),
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => Get.to(() => const BlogDetailView(), transition: Transition.fade),
                child: Column(
                  children: [
                    Container(
                      height: 50.sp,
                      width: 64.w,
                      decoration: const BoxDecoration(
                          color: greyblue,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                          image: DecorationImage(
                              image: NetworkImage(dummyImg1), fit: BoxFit.cover)),
                    ),
                    Container(
                      height: 55.sp,
                      width: 64.w,
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                      ),
                      padding: EdgeInsets.all(12.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "11 Unforgettable Experiences that Await in Guatemala",
                            style: midTextStyle.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                            "06 July 2024",
                            style: smallTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 13.sp, color: greyblueDrkDrk),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                            """Adventure is out there…in Guatemala! Even though it is one of the most underrated countries to visit, Guatemala is a treasure trove of experiences for 
                            curious adventurers, and not just of the adrenaline-pumping sort.""",
                            style: smallTextStyle,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 15.sp,
            ),
          ),
        )
      ] 
    );
  }

  guideSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.sp),
          child: Text(
            "Guides Nearby",
            style: titleStyle,
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        ListView.builder(
          itemCount: controller.guidesList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(15.sp),
              onTap: () {
                Get.to(()=> const GuideDetailView(), transition: Transition.fade);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 52.sp,
                        width: 45.sp,
                        margin: EdgeInsets.only(left: 16.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            border: Border.all(
                              color: white,
                              width: 6
                            ),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://raw.githubusercontent.com/jyodesh10/find-my-guide/04050359b7c8a0a13ad9a573f8590401b12532e3/${controller.guidesList[index].image}"),
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 15.sp,
                          backgroundColor: white,
                          child: const Icon(Icons.check, color: green,),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                          "${controller.guidesList[index].firstname} ${controller.guidesList[index].lastname}", style: midTextStyle.copyWith(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${controller.guidesList[index].location.city}, ${controller.guidesList[index].location.country}", style: subtitleStyle,),
                          Divider(
                            color: black.withOpacity(0.1),
                            thickness: 1.5,
                          ),
                          RatingBar.readOnly(
                            filledIcon: Icons.star_rounded, 
                            emptyIcon: Icons.star_border_rounded,
                            size: 20.sp,
                            initialRating: 4,
                            maxRating: 5,
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "\$ ",
                              style:  titleStyle.copyWith(fontSize: 15.5.sp, color: blue ),
                              children: [
                                TextSpan(
                                  text: "12 / hour",
                                  style: titleStyle.copyWith(fontSize: 17.5.sp, color: blue )
                                )
                              ]
                            )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
