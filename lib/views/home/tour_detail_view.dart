import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/home_controller.dart';
import 'package:findmyguide/controllers/wishlist_controller.dart';
import 'package:findmyguide/widgets/custom_cacheimage.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../models/tours_model.dart';
import '../../widgets/review_card.dart';

class TourDetailView extends StatefulWidget {
  const TourDetailView({super.key, required this.id});
  final String id;

  @override
  State<TourDetailView> createState() => _TourDetailViewState();
}

class _TourDetailViewState extends State<TourDetailView> {

  final controller = Get.put(HomeController());
  final wishlistcontroller = Get.put(WishlistController());
  CarouselController? carouselController;
  @override
  void initState() {
    super.initState();
    controller.getTourById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      appBar: AppBar(
        backgroundColor: primaryClr,
        scrolledUnderElevation: 0.5,
        actions: [
          Obx(() => wishlistcontroller.loading.isTrue || controller.tourloading.isTrue
            ? const SizedBox()
            : IconButton(
              onPressed: () {
                wishlistcontroller.addToWishlist(controller.tour.id.toString());
              },
              icon: Icon(
                wishlistcontroller.wishlistdata.wishlist!.map((e)=> e.tour!.id.toString()).toList().contains(controller.tour.id.toString())
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded,
                color: pink,
              ),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => controller.tourloading.isTrue
            ? const LoadingGif()
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.sp,
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
      ),
      bottomNavigationBar: Obx(() => controller.tourloading.isTrue
        ? const LinearProgressIndicator(color: blue,)
        :
        Container(
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
                    controller.tour.price.toString(),
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
      ),
    );
  }

  titleImgSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: 60.sp,
            // width: 90.w,
            child: CarouselView(
              shrinkExtent: 1.w,
              itemExtent: 80.w,
              controller: carouselController,
              elevation: 5,
              padding: EdgeInsets.only(left: 15.sp),
              itemSnapping: true,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              children: List.generate(controller.tour.image!.length, (index) {
                return CustomCachedNetworkImage(imageUrl: controller.tour.image![index].toString());
              })
            )
          )
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(top: 15.sp),
          child: Text(
            controller.tour.title.toString(),
            style: titleStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.sp),
          child: Text(
            "Hosted by: Ghanshyam",
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
                  content: "${controller.tour.highlights?.location?.city}, ${controller.tour.highlights?.location?.country}"),
              highlightsTile(
                  icon: Icon(
                    Icons.access_time_filled_rounded,
                    size: 19.sp,
                    color: black,
                  ),
                  content: controller.tour.highlights!.duration.toString()),
              highlightsTile(
                  icon: Icon(
                    Icons.language,
                    size: 19.sp,
                    color: black,
                  ),
                  content: controller.tour.highlights!.languages.toString().replaceAll("[", "").replaceAll("]", "")),
              highlightsTile(
                  icon: Icon(
                    Icons.info_rounded,
                    size: 19.sp,
                    color: black,
                  ),
                  content: controller.tour.highlights!.specializations.toString().replaceAll("[", "").replaceAll("]", "")),
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
            controller.tour.description.toString(),
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
          child: Column(
            children: List.generate(controller.tour.reviews!.length, (index) {
              Review review = controller.tour.reviews![index];
              return ReviewCard(
                comment: review.comment.toString(),
                name: review.user!.username.toString(),
                image: review.user!.image.toString(),
                rating: review.rating.toString(),
              );
            }) 
          ),
        )
      ],
    );
  }

}
