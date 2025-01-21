import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/home_controller.dart';
import 'package:findmyguide/views/home/blog_detail_view.dart';
import 'package:findmyguide/views/home/bloglist_view.dart';
import 'package:findmyguide/views/home/guide_detail_view.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/url_constants.dart';
import '../../utils/date_formatter.dart';
import '../../widgets/custom_cacheimage.dart';
import 'tour_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 200), () async {
              await controller.fetchall();
            });
          },
          color: blue,
          backgroundColor: white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topSection(),
                searchSection(),
                Obx(() => controller.loading.isTrue
                  ? const Center(child: LoadingGif())
                  : Column(
                      children: [
                        // locationsSection(),
                        toursSection(),
                        blogsSection(),
                        guideSection(),
                      ],
                    )
                ),
                SizedBox(
                  height: 50.sp,
                )
              ],
            ),
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
                  offset: const Offset(0, 2))
            ]),
        child: TextFormField(
          cursorColor: greyblueDrkDrk,
          cursorHeight: 20.sp,
          autofocus: false,
          decoration: InputDecoration(
              filled: true,
              fillColor: white,
              prefixIcon: const Icon(Icons.search, color: greyblueDrkDrk),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.sp),
                borderSide: BorderSide.none,
              ),
              hintText: "Search tours, blogs or guides...",
              hintStyle: midTextStyle.copyWith(color: greyblueDrkDrk)),
        ));
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
              Text(
                "Patan",
                style: subtitleStyle,
              )
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
            "Tours",
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
                  Get.to(() => const TourDetailView(),
                      transition: Transition.fade);
                },
                child: Column(
                  children: [
                    Card(
                      color: transparent,
                      elevation: 10,
                      shadowColor: black.withOpacity(0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Stack(
                        children: [
                          Container(
                            height: 52.sp,
                            width: 60.w,
                            margin: EdgeInsets.only(bottom: 10.sp),
                            decoration: BoxDecoration(
                                color: greyblue,
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        index == 0 ? dummyImg2 : dummyImg),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 12.sp, left: 12.sp),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.sp, vertical: 5.sp),
                            decoration: BoxDecoration(
                              color: greyblue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              controller.toursList[index].highlights!.duration
                                  .toString(),
                              style: smallTextStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35.sp,
                      width: 58.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.toursList[index].title.toString(),
                            style: midTextStyle.copyWith(
                                fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            controller.toursList[index].price.toString(),
                            style: smallTextStyle.copyWith(color: blue, fontWeight: FontWeight.bold),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Blogs",
              style: titleStyle,
            ),
            TextButton(
              onPressed: () {
                controller.initialPage.value = 1;
                controller.blogsList.clear();
                for (var i = 0; i < controller.blogsHomeList.length; i++) {
                  if(!controller.blogsList.map((f) => f.id).toList().contains(controller.blogsHomeList[i].id)) {
                    controller.blogsList.add(controller.blogsHomeList[i]);
                  }
                }
                Get.to(() => const BloglistView(), transition: Transition.rightToLeft); 
              }, 
              child: Text("View all", style: smallTextStyle.copyWith(color: blue, fontWeight: FontWeight.bold),)
            )
          ],
        ),
      ),
      SizedBox(
        height: 75.sp,
        child: ListView.separated(
          itemCount: controller.blogsHomeList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => Get.to(() => BlogDetailView(id: controller.blogsHomeList[index].id.toString(),),
                  transition: Transition.fade),
              child: Card(
                color: white,
                elevation: 10,
                shadowColor: black.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Container(
                      height: 50.sp,
                      width: 64.w,
                      decoration: const BoxDecoration(
                        color: greyblue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius:  const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)
                        ),
                        child: CustomCachedNetworkImage(imageUrl: controller.blogsHomeList[index].image.toString()),
                      ),

                    ),
                    Container(
                      height: 54.sp,
                      width: 64.w,
                      decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      padding: EdgeInsets.all(12.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.blogsHomeList[index].title.toString(),
                            style: midTextStyle.copyWith(
                                fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                            DateTimeFormatter.formatDate(controller.blogsHomeList[index].createdAt.toString()),
                            style: smallTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                color: greyblueDrkDrk),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                            controller.blogsHomeList[index].content.toString(),
                            style: smallTextStyle,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 15.sp,
          ),
        ),
      )
    ]);
  }

  guideSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15.sp,
        ),
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
                Get.to(() => const GuideDetailView(),
                    transition: Transition.fade);
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
                          border: Border.all(color: white, width: 6),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.sp),
                          child: CustomCachedNetworkImage(imageUrl: "${controller.guidesList[index].image}")
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child:  controller.guidesList[index].isVerified == false
                          ? const SizedBox()
                          : CircleAvatar(
                            radius: 15.sp,
                            backgroundColor: white,
                            child: const Icon(
                              Icons.check,
                              color: green,
                            ),
                          ),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                          "${controller.guidesList[index].firstname} ${controller.guidesList[index].lastname}",
                          style: midTextStyle.copyWith(
                              fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.guidesList[index].location?.city}, ${controller.guidesList[index].location?.country}",
                            style: subtitleStyle,
                          ),
                          Divider(
                            color: black.withOpacity(0.1),
                            thickness: 1.5,
                          ),
                          RatingBar.readOnly(
                            filledIcon: Icons.star_rounded,
                            emptyIcon: Icons.star_border_rounded,
                            size: 20.sp,
                            initialRating: double.parse( controller.guidesList[index].rating.toString()),
                            maxRating: 5,
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: controller.guidesList[index].price?[0],
                                  style: titleStyle.copyWith(
                                      fontSize: 15.5.sp, color: blue),
                                  children: [
                                TextSpan(
                                    text: controller.guidesList[index].price?.replaceAll("\$", ""),
                                    style: titleStyle.copyWith(
                                        fontSize: 17.5.sp, color: blue))
                              ]))
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
