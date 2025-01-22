

import 'package:findmyguide/models/wishlist_model.dart';
import 'package:findmyguide/utils/dialog_boxes.dart';
import 'package:get/get.dart';

import '../constants/url_constants.dart';
import '../utils/http_handler.dart';
import '../utils/shared_pref.dart';

class WishlistController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getWishlist();
  }

  var loading = false.obs;
  late WishlistModel wishlistdata;
  Future getWishlist() async {
    loading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/wishlist", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    );
    wishlistdata = WishlistModel.fromMap(data);
    loading(false);
  }


  Future addToWishlist(String tourid) async {
    var data = await handleRequest(
      method: "post", 
      url: "${baseUrl}api/wishlist",
      body: {
        "tour": tourid
      },
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    );
    if(data['error'] == false) {
      customsnackBar(message: "Added to wishlist");
      await getWishlist();
    }
  }

  Future deleteWishlistbyId(String id) async {
    var data =await handleRequest(
      method: "delete", 
      url: "${baseUrl}api/wishlist/$id",
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    );
    if(data['error'] == false) {
      await getWishlist();
      customsnackBar(message: "Removed from wishlist");
    }
  }

}