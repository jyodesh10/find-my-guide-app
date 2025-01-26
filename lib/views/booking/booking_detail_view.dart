import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/utils/date_formatter.dart';
import 'package:findmyguide/views/home/tour_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../controllers/booking_controller.dart';
import '../../widgets/custom_cacheimage.dart';
import '../../widgets/loading_widgets.dart';

class BookingDetailView extends StatefulWidget {
  const BookingDetailView({super.key, required this.id});
  final String id;

  @override
  State<BookingDetailView> createState() => _BookingDetailViewState();
}

class _BookingDetailViewState extends State<BookingDetailView> {

  final controller = Get.put(BookingController());

  final ScrollController _scrollController = ScrollController();
  CarouselController? carouselController;

  @override
  void initState() {
    super.initState();
    controller.getBookingById(widget.id);
    _scrollController.addListener(() {
      // if(_scrollController.offset >= 190) {
      //   controller.appbarOffset.value = Offset.zero;
      // } else {
      //   controller.appbarOffset.value = const Offset(10,0);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      // appBar: AppBar(
      //   backgroundColor: primaryClr,
      //   scrolledUnderElevation: 0.5,
      //   title: Text("Booking Details" , style: titleStyle,),
      // ),
      body: Obx(() => controller.bookingdetailloading.isTrue
        ? const LoadingGif()
        : CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: primaryClr,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: white,
                ),
              ),
              expandedHeight: 55.sp,
              pinned: true,
              floating: false,
              foregroundColor: primaryClr,
              scrolledUnderElevation: 0.5,
              // title: Text(controller.bookingbyId.tour!.title.toString(), style: titleStyle, overflow: TextOverflow.ellipsis,),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CustomCachedNetworkImage(imageUrl: controller.bookingbyId.tour!.image!.first.toString(), height: 60.sp, width:  double.infinity,),
                    Container(
                      height: 60.sp,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [black.withOpacity(0.5), white.withOpacity(0.02), transparent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          stops: const [0, 0.6, 1]
                        )
                      ),
                    ),
                  ],
                ),
              )
            ),
            SliverToBoxAdapter( 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Text(controller.bookingbyId.tour!.title.toString(), style: titleStyle,),
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => TourDetailView(id: controller.bookingbyId.tour!.id.toString()) ),
                    child: Text("View Tour Details >>>", style: midTextStyle.copyWith(color: black))
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20.sp, top: 15.sp, bottom: 15.sp),
                    padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp).copyWith(bottom: 7.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: controller.bookingbyId.status == "Pending"
                          ? amber
                          : controller.bookingbyId.status == "Confirmed"
                            ? green
                            : red,
                        width: 1.8
                      )
                    ),
                    child: Text("${controller.bookingbyId.status}", style: subtitleStyle.copyWith(fontWeight: FontWeight.bold , color: controller.bookingbyId.status == "Pending"
                      ? amber
                      : controller.bookingbyId.status == "Confirmed"
                        ? green
                        : red
                    ),),
                  ),
                  ListTile(
                    minTileHeight: 10.sp,
                    leading: Icon(Icons.date_range, size: 20.sp,),
                    title: Text("Booked for", style:  subtitleStyle,),
                    subtitle: Text(DateTimeFormatter.formatDate(controller.bookingbyId.bookedfor.toString()), style: midTextStyle,),
                  ),
                  ListTile(
                    minTileHeight: 10.sp,
                    leading: Icon(Icons.group_outlined, size: 20.sp,),
                    title: Text("Participants", style:  subtitleStyle,),
                    subtitle: Text(controller.bookingbyId.participants.toString(), style: midTextStyle,),
                  ),
                  ListTile(
                    minTileHeight: 10.sp,
                    leading: Icon(Icons.price_change_outlined, size: 20.sp,),
                    title: Text("Price", style:  subtitleStyle,),
                    subtitle: Text(controller.bookingbyId.tour!.price.toString(), style: midTextStyle,),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  controller.bookingbyId.status == "Pending"
                    ? Center(
                      child: MaterialButton(
                        color: red.withOpacity(0.8),
                        height: 25.sp,
                        minWidth: 38.w,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
                        child: Text("Cancel Booking", style: midTextStyle.copyWith(color: white),),
                        onPressed: () async {
                          Get.defaultDialog(
                            title: "Are you sure?",
                            titleStyle: titleStyle,
                            backgroundColor: white,
                            content: const SizedBox(),
                            contentPadding: EdgeInsets.zero,
                            cancel: TextButton(
                              onPressed: () async {
                                Get.back();
                                await controller.cancelBookingbyId(widget.id);
                              },
                              child: Text("Yes", style: midTextStyle.copyWith(color: black))
                            ),
                            confirm: TextButton(
                              onPressed: () => Get.back(),
                              child: Text("No", style: midTextStyle.copyWith(color: black))
                            ),
                          );
                        
                        },
                      ),
                    )
                    : const SizedBox()
                  // SizedBox(
                  //   height: 8.sp,
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 18.sp).copyWith(bottom: 15.sp),
                  //   child: Text(
                  //     controller.blog.content.toString(),
                  //     style: smallTextStyle,
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
