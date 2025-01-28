import 'package:findmyguide/controllers/booking_controller.dart';
import 'package:findmyguide/models/booking_model.dart';
import 'package:findmyguide/utils/date_formatter.dart';
import 'package:findmyguide/views/booking/booking_detail_view.dart';
import 'package:findmyguide/widgets/custom_cacheimage.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_widget.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {

  final controller = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    controller.getBooking();
    return Scaffold(
      backgroundColor: primaryClr,
      appBar: customAppbar(title: "Bookings", hasLeading: false),
      body: Obx(() => controller.loading.isTrue
        ? const LoadingGif()
        : controller.bookingdata.booking!.isNotEmpty 
          ? ListView.separated(
            itemCount: controller.bookingdata.booking!.length,
            // shrinkWrap: true,
            itemBuilder: (context, index) {
              Booking booking = controller.bookingdata.booking![index];
              return bookingTile(booking);
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 18.sp,
                thickness: 1.5,
                color: black.withOpacity(0.1),
                endIndent: 15.sp,
                indent: 15.sp,
              );
            }, 
          )
          : const EmptyWidget(text: "No bookings",)
      ) 
    );
  }
  
  bookingTile(Booking booking) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 18.sp),
      color: white,
      elevation: 10,
      shadowColor: black.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Get.to(() => BookingDetailView(id: booking.id.toString()));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomCachedNetworkImage(imageUrl: booking.tour!.image!.first.toString(), fit: BoxFit.cover, height: 42.sp, width: 30.w,),
            ),
            SizedBox(
              width: 12.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${booking.tour!.title}", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),maxLines: 2, overflow: TextOverflow.ellipsis,),
                  SizedBox(
                    height: 5.sp,
                  ),
                  Text("Booked for ${DateTimeFormatter.formatDate(booking.bookedfor.toString())}", style: smallTextStyle,),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp).copyWith(bottom: 7.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: booking.status == "Pending"
                          ? amber
                          : booking.status == "Confirmed"
                            ? green
                            : red,
                        width: 1.8
                      )
                    ),
                    child: Text("${booking.status}", style: subtitleStyle.copyWith(fontWeight: FontWeight.bold , color: booking.status == "Pending"
                      ? amber
                      : booking.status == "Confirmed"
                        ? green
                        : red
                    ),),
                  ),
                  SizedBox(
                    height: 5.sp,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum Status  {confirmed, cancelled, pending}
