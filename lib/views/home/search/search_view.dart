import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:findmyguide/models/guides_model.dart';
import 'package:findmyguide/models/tours_model.dart';
import 'package:findmyguide/views/home/guide/guide_detail_view.dart';
import 'package:findmyguide/views/home/tour/tour_detail_view.dart';
import 'package:findmyguide/widgets/custom_cacheimage.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/font_constants.dart';
import '../../../controllers/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  final controller = Get.put(SearchHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: ()=> Get.back(), icon: const  Icon(Icons.arrow_back_rounded, color: black,)),
                Expanded(
                  child: searchSection()
                )
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: DropdownMenu(
                initialSelection: controller.filter.value,
                leadingIcon: const Icon(Icons.filter_list_rounded, color: greyblueDrkDrk,),
                menuStyle: MenuStyle(
                  backgroundColor: const WidgetStatePropertyAll(white),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)))
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  contentPadding: EdgeInsets.zero,
                  iconColor: black
                ),
                onSelected: (value) async {
                  if(value == 0) {
                    controller.filter.value = 0;
                  } else {
                    controller.filter.value = 1;
                  }
                },
                dropdownMenuEntries:const [
                  DropdownMenuEntry(value: 0, label: "Tour",),
                  DropdownMenuEntry(value: 1, label: "Guide"),
                ]
              ),
            ),
            Expanded(
              child: Obx(() => controller.filter.value == 0
                ? searchTourListview()
                : searchGuideListview()
              )
            )
          ],
        ),
      ),
    );
  }

  searchSection() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 0.sp, vertical: 10.sp).copyWith(right: 15.sp),
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
          autofocus: true,
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) {
           controller.searchTour(value);
           controller.searchGuide(value);
          },
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
  
  searchTourListview() {
    return Obx(() => controller.tourloading.isTrue
      ? const LoadingGif()
      : ListView.separated(
        itemBuilder: (context, index) {
          ToursModel tour = controller.searchTourData[index];
          return GestureDetector(
            onTap: () => Get.to(()=> TourDetailView(id: tour.id.toString())),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(12.sp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomCachedNetworkImage(imageUrl: tour.image!.first, height: 40.sp, width: 40.sp,),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tour.title.toString(), style: titleStyle.copyWith(fontSize: 16.sp),),
                        Text("\$ ${tour.price!.numberDecimal} / ${tour.pricePer}", style: smallTextStyle.copyWith(color: blue, fontWeight: FontWeight.bold),),
                        Text("${tour.highlights!.duration}", style: smallTextStyle,),
                        RatingBar.readOnly(
                          filledIcon: Icons.star_rounded,
                          emptyIcon: Icons.star_border_rounded,
                          size: 20.sp,
                          initialRating: double.parse(tour.rating.toString()),
                          maxRating: 5,
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          );
        }, 
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.sp,
          );
        }, 
        itemCount: controller.searchTourData.length
      ),
    );
  }
  
  searchGuideListview() {
    return Obx(() => controller.guideloading.isTrue
      ? const LoadingGif()
      : ListView.separated(
        itemBuilder: (context, index) {
          GuidesModel guide = controller.searchGuideData[index];
          return GestureDetector(
            onTap: () => Get.to(()=> GuideDetailView(id: guide.id.toString())),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(12.sp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomCachedNetworkImage(imageUrl: guide.image.toString(), height: 40.sp, width: 40.sp,),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("${guide.firstname} ${guide.lastname}", style: titleStyle.copyWith(fontSize: 16.sp),),
                        Text("${guide.location!.city}, ${guide.location!.country}", style: smallTextStyle.copyWith(color: black,),),
                        Text("\$ ${guide.price!.numberDecimal} / ${guide.pricePer}", style: smallTextStyle.copyWith(color: blue, fontWeight: FontWeight.bold),),
                        // Text("${tour.highlights!.duration}", style: smallTextStyle,),
                        RatingBar.readOnly(
                          filledIcon: Icons.star_rounded,
                          emptyIcon: Icons.star_border_rounded,
                          size: 20.sp,
                          initialRating: double.parse(guide.rating.toString()),
                          maxRating: 5,
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
          );
        }, 
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.sp,
          );
        }, 
        itemCount: controller.searchGuideData.length
      ),
    );
  }

}