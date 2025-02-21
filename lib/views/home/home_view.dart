import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/home_controller.dart';
import 'package:findmyguide/models/home_model.dart';
import 'package:findmyguide/views/home/blog/blog_detail_view.dart';
import 'package:findmyguide/views/home/blog/bloglist_view.dart';
import 'package:findmyguide/views/home/guide/guide_detail_view.dart';
import 'package:findmyguide/views/home/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/url_constants.dart';
import '../../controllers/profile_controller.dart';
import '../../utils/date_formatter.dart';
import '../../widgets/custom_cacheimage.dart';
import '../../widgets/loading_widgets.dart';
import 'tour/tour_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());
  final profilecontroller = Get.put(ProfileController());

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    // controller.getLocation();
    return Scaffold(
      backgroundColor: primaryClr,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(backgroundImg, fit: BoxFit.cover,),
          SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 200), () async {
                  await controller.fetchall();
                });
              },
              color: blue,
              backgroundColor: white,
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: topSection(),
                  ),
                  SliverAppBar(
                    backgroundColor: transparent,
                    elevation: 0,
                    expandedHeight: 35.sp,
                    collapsedHeight: 35.sp,
                    scrolledUnderElevation: 0,
                    flexibleSpace: Center(
                      child: searchSection(),
                    ),
                    pinned: true,
                    floating: true,
                    centerTitle: true,
                    snap: true,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // topSection(),
                        // searchSection(),
                        Obx(() => 
                          AnimatedOpacity(
                            duration: const Duration(
                              milliseconds: 600,
                            ),
                            opacity: controller.loading.isTrue /* || profilecontroller.loading.isTrue */ ? 0.0 : 1.0,
                            child: controller.loading.isTrue/*  || profilecontroller.loading.isTrue */
                              ? 
                              // const SizedBox()
                              const Center(child: LoadingGif())
                              : Column(
                                children: [
                                  // locationsSection(),
                                  toursSection(),
                                  blogsSection(),
                                  guideSection(),
                                ],
                              ),
                          )
                        ),
                        SizedBox(
                          height: 50.sp,
                        )
                      ],
                    ),
                  )
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }

  topSection() {
    return Obx(() =>
      AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInSine,
        opacity: profilecontroller.loading.isTrue ?  0 : 1,
        child: SizedBox(
          height: 45.sp,
          child: Obx(() => 
            profilecontroller.loading.isTrue
              ? const SizedBox() 
              : Column(
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
                              "Good Morning,\n${profilecontroller.user.username}",
                              style: titleStyle.copyWith(
                                  fontSize: 17.sp, color: black.withOpacity(0.8)),
                            ),
                            SizedBox(
                              height: 12.sp,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await controller.getLocation();
                              },
                              child: Obx(() => controller.locationLoading.isTrue
                                ? Container(
                                  height: 18.sp,
                                  width: 50.sp,
                                  padding: EdgeInsets.symmetric(vertical: 12.sp),
                                  child: const LinearProgressIndicator(
                                      minHeight: 1,
                                      color: blue,
                                      backgroundColor: primaryClr,
                                  ),
                                )
                                : Row(
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
                                      profilecontroller.user.location?.city != "null" || profilecontroller.user.location?.country != "null"
                                       ? "${profilecontroller.user.location?.city}, ${profilecontroller.user.location?.country}"
                                       : "Tap to get your location",
                                      style: midTextStyle.copyWith(
                                          fontSize: 14.sp, color: greyblueDrkDrk),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: profilecontroller.user.image.toString(), fit: BoxFit.cover, height: 32.sp, width: 32.sp
                            )
                          ), 
                        )
                      ],
                    ),
                  ),
                ],
              ),
          ) 
        ),
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
          readOnly: true,
          onTap: () => Get.to(() => const SearchView()),
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
            "Recommended Tours",
            style: titleStyle,
          ),
        ),
        SizedBox(
          height: 12.sp,
        ),
        SizedBox(
          height: 65.sp,
          child: ListView.separated(
            itemCount: controller.homedata.recommendedTours!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 18.sp),
            itemBuilder: (context, index) {
              RecommendedTour tours = controller.homedata.recommendedTours![index];
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Get.to(() => TourDetailView(id:tours.id.toString() ,),
                      transition: Transition.fade);
                },
                child: Column(
                  children: [
                    Card(
                      color: transparent,
                      elevation: 10,
                      shadowColor: black.withOpacity(0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Stack(
                        children: [
                          Container(
                            height: 52.sp,
                            width: 60.w,
                            margin: EdgeInsets.only(bottom: 10.sp),
                            decoration: BoxDecoration(
                              color: greyblue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CustomCachedNetworkImage(imageUrl: tours.image!.first.toString(), height: 52.sp, width: 60.w,),
                            ),
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
                              tours.highlights!.duration
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
                            tours.title.toString(),
                            style: midTextStyle.copyWith(
                                fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "\$ ${tours.price!.numberDecimal} / ${tours.pricePer}",
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
                // controller.blogsList.clear();
                // for (var i = 0; i < controller.blogsHomeList.length; i++) {
                //   if(!controller.blogsList.map((f) => f.id).toList().contains(controller.blogsHomeList[i].id)) {
                //     controller.blogsList.add(controller.blogsHomeList[i]);
                //   }
                // }
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
          itemCount: controller.homedata.blogs!.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          itemBuilder: (context, index) {
            Blog blogs = controller.homedata.blogs![index];
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Get.to(() => BlogDetailView(id: blogs.id.toString(),),
                  transition: Transition.fade),
              child: Card(
                color: white,
                elevation: 10,
                shadowColor: black.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Container(
                      height: 50.sp,
                      width: 64.w,
                      decoration: const BoxDecoration(
                        color: greyblue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius:  const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)
                        ),
                        child: CustomCachedNetworkImage(imageUrl:blogs.image.toString()),
                      ),

                    ),
                    Container(
                      height: 54.sp,
                      width: 64.w,
                      decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                      padding: EdgeInsets.all(12.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blogs.title.toString(),
                            style: midTextStyle.copyWith(
                                fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          Text(
                            DateTimeFormatter.formatDate(blogs.createdAt.toString()),
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
                            blogs.content.toString(),
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
        ListView.separated(
          itemCount: controller.homedata.guidesNearby!.length,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            GuidesNearby guides = controller.homedata.guidesNearby![index];
            return InkWell(
              borderRadius: BorderRadius.circular(15.sp),
              onTap: () {
                Get.to(() => GuideDetailView(id:guides.id.toString(),),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          border: Border.all(color: white, width: 6),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 5,
                              color: black.withOpacity(0.08)
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.sp),
                          child: CustomCachedNetworkImage(imageUrl: "${guides.image}")
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child:  guides. isVerified == false
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
                          "${guides.firstname} ${guides.lastname}",
                          style: midTextStyle.copyWith(
                              fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${guides.location?.city}, ${guides.location?.country}",
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
                            initialRating: double.parse( guides.rating.toString()),
                            maxRating: 5,
                          ),
                          SizedBox(
                            height: 8.sp,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: "\$ ",
                                  style: titleStyle.copyWith(
                                      fontSize: 15.5.sp, color: blue),
                                  children: [
                                TextSpan(
                                    text: "${guides.price!.numberDecimal} / ${guides.pricePer}",
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
          separatorBuilder: (context, index) => SizedBox(height: 12.sp,),
        )
      ],
    );
  }
}
