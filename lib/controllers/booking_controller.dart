

import 'package:findmyguide/models/booking_model.dart';
import 'package:findmyguide/utils/dialog_boxes.dart';
import 'package:get/get.dart';

import '../constants/url_constants.dart';
import '../utils/http_handler.dart';
import '../utils/shared_pref.dart';

class BookingController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getBooking();
  }

  var loading = false.obs;
  late BookingModel bookingdata;
  Future getBooking() async {
    loading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/booking", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    );
    bookingdata = BookingModel.fromMap(data);
    loading(false);
  }

  late Booking bookingbyId;
  var bookingdetailloading = false.obs;
  Future getBookingById(String bookingId) async {
    bookingdetailloading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/booking/$bookingId", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    );
    bookingbyId = Booking.fromMap(data["booking"]);
    bookingdetailloading(false);
  }


  Future addToBooking(String tourid, String date) async {
    var data = await handleRequest(
      method: "post", 
      url: "${baseUrl}api/booking",
      body: {
        "tour": tourid,
        "bookedfor": date
      },
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    );
    if(data['error'] == false) {
      customsnackBar(message: "Tour Booked");
      await getBooking();
    }
  }

  Future cancelBookingbyId(String id) async {
    loadingDialog();
    var data =await handleRequest(
      method: "put", 
      url: "${baseUrl}api/booking/$id",
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
      body: {
        "status": "Cancelled"
      }
    );
    Get.back();
    Get.back();
    if(data['error'] == false) {
      await getBooking();
      customsnackBar(message: "Cancelled booking");
    }
  }

}