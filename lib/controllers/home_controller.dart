


import 'package:findmyguide/constants/url_constants.dart';
import 'package:findmyguide/models/guides_model.dart';
import 'package:findmyguide/models/tours_model.dart';
import 'package:findmyguide/utils/http_handler.dart';
import 'package:findmyguide/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  TextEditingController emailcon = TextEditingController();
  TextEditingController passwordcon = TextEditingController();

  var toursList = <ToursModel>[].obs;
  var guidesList = <GuidesModel>[].obs;

  Future getToursRequest() async {
    List data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/tours", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    );
    
    toursList.value = data.map((e) => ToursModel.fromJson(e)).toList();

  }


  Future getGuidesRequest() async {
    List data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/guides", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    );
    
    guidesList.value = data.map((e) => GuidesModel.fromMap(e)).toList();

  }

}