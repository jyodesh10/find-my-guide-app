


import 'package:findmyguide/constants/url_constants.dart';
import 'package:findmyguide/models/blogs_model.dart';
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
  var blogsList = <BlogData>[].obs;

  var loading = false.obs;

  Future getToursRequest() async {
    loading(true);
    List data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/tours", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    ).whenComplete(() => loading(false));
    
    toursList.value = data.map((e) => ToursModel.fromJson(e)).toList();

  }


  Future getGuidesRequest() async {
    loading(true);
    List data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/guides", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    ).whenComplete(() => loading(false));
    
    guidesList.value = data.map((e) => GuidesModel.fromMap(e)).toList();

  }


  Future getBlogsRequest() async {
    loading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/blog/?limit=5&page=1", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    ).whenComplete(() => loading(false));
    List listdata = data['data'];
    blogsList.value = listdata.map((e) => BlogData.fromMap(e)).toList();

  }

  late BlogData blog;
  var blogloading = false.obs;
  Future getBlogById(id) async {
    blogloading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/blog/$id", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    ).whenComplete(() => blogloading(false));
    blog = BlogData.fromMap(data);
  }

}