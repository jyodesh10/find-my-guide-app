import 'package:findmyguide/models/tours_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/url_constants.dart';
import '../utils/http_handler.dart';
import '../utils/shared_pref.dart';

class SearchHomeController extends GetxController {
  Map<String, String>? headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer ${SharedPref.read("accessToken")}"
  };

  var loading = false.obs;
  List<ToursModel> searchTourData = [];
  Future searchTour(String query) async {
    loading(true);
    try {
      var data = await handleRequest(
          method: "get",
          url: "${baseUrl}api/tours?search=$query",
          headers: headers);
      List tourlist = data['data'];
      searchTourData = tourlist.map((e)=> ToursModel.fromMap(e)).toList();
      loading(false);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}



