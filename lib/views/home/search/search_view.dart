import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:findmyguide/models/tours_model.dart';
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
            Expanded(
              child: Obx(() => controller.loading.isTrue
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
                                  Text("${tour.highlights!.duration}", style: smallTextStyle,),
                                  Text("${tour.price}", style: smallTextStyle,),
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
          onFieldSubmitted: (value) => controller.searchTour(value),
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

}