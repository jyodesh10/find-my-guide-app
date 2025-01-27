import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/home_controller.dart';
import 'package:findmyguide/controllers/wishlist_controller.dart';
import 'package:findmyguide/views/home/guide/guide_detail_view.dart';
import 'package:findmyguide/widgets/custom_cacheimage.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../constants/color_constants.dart';
import '../../../controllers/booking_controller.dart';
import '../../../models/tours_model.dart';
import '../../../utils/date_picker.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/review_card.dart';

class TourDetailView extends StatefulWidget {
  const TourDetailView({super.key, required this.id});
  final String id;

  @override
  State<TourDetailView> createState() => _TourDetailViewState();
}

class _TourDetailViewState extends State<TourDetailView> {

  final controller = Get.put(HomeController());
  final wishlistcontroller = Get.put(WishlistController());
  final bookingcontroller = Get.put(BookingController());
  CarouselController? carouselController;

  final GlobalKey _formKey = GlobalKey<FormState>(); 

  @override
  void initState() {
    super.initState();
    controller.getTourById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      resizeToAvoidBottomInset: false,
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
      body: SingleChildScrollView(
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
                onPressed: () {
                  confirmBookingBottomsheet(context);
                }),
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
        GestureDetector(
          onTap: () => Get.to(() => GuideDetailView(id: controller.tour.guide!.id.toString())),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.sp),
            child: Text(
              "Hosted by: ${controller.tour.guide!.firstname} ${controller.tour.guide!.lastname}",
              style: subtitleStyle,
            ),
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
            style: smallTextStyle.copyWith(height: 4.2.sp, fontWeight: FontWeight.bold),
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

  var participants = 1.obs;
  void confirmBookingBottomsheet(BuildContext context) {
    TextEditingController date = TextEditingController();
    participants.value = 1; 
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
        return  StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: primaryClr
                ),
                child:Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.sp,
                      ),
                      Divider(
                        color: black.withOpacity(0.3),
                        height: 15.sp,
                        thickness: 3,
                        endIndent: 40.w,
                        indent: 40.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 10.sp),
                        child: Text("Prticipants", style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 18.sp,
                          ),
                          MaterialButton(
                            onPressed: (){
                              participants.value++;
                            },
                            minWidth: 30.sp,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                            ),
                            color: blue,
                            child: Text("+", style: titleStyle.copyWith(color: white),),
                          ),
                          SizedBox(
                            width: 15.sp,
                          ),
                          Obx(() => Text(participants.value.toString(), style: titleStyle.copyWith(color: black),)),
                          SizedBox(
                            width: 15.sp,
                          ),
                          MaterialButton(
                            onPressed: (){
                              if(participants.value > 1) {
                                participants.value--;
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                            ),
                            color: blue,
                            minWidth: 30.sp,
                            child: Text("-", style: titleStyle.copyWith(color: white),),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                        child: Text("Book for (Date)", style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),),
                      ),
                      CustomTextfield(
                        hintText: "mm/dd/yy",
                        readOnly: true,
                        controller: date,
                        onTap: () async {
                          String? pickeddate = await customDatePicker(context, lastDate: DateTime(DateTime.now().add(const Duration(days: 10000)).year));
                          if(pickeddate!.isNotEmpty){
                            date.text = pickeddate.toString();
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price", style: midTextStyle.copyWith(fontWeight: FontWeight.bold, color: blue),),
                            Obx(()=> Text("${participants.value} x ${controller.tour.price}", style: midTextStyle,)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      Center(
                        child: MaterialButton(
                          color: blue,
                          height: 28.sp,
                          minWidth: 38.w,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
                          child: Text("Confirm", style: midTextStyle.copyWith(color: white),),
                          onPressed: () async {
                            if(date.text.isNotEmpty) {
                              Get.back();
                              await bookingcontroller.addToBooking(controller.tour.id.toString(), date.text).whenComplete(() {
                                participants.value = 1;
                                date.clear();
                              });
                            } else {
                              Fluttertoast.showToast(msg: "Date is required");
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                    ],
                  ),
                )
              ),
            );
          },
        );
      },
    );
  }

}
