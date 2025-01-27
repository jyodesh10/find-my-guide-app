


import 'package:findmyguide/constants/url_constants.dart';
import 'package:findmyguide/controllers/profile_controller.dart';
import 'package:findmyguide/models/blogs_model.dart';
import 'package:findmyguide/models/guides_model.dart';
import 'package:findmyguide/models/tours_model.dart';
import 'package:findmyguide/utils/http_handler.dart';
import 'package:findmyguide/utils/location_helper.dart';
import 'package:findmyguide/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/home_model.dart';


class HomeController extends GetxController{
  TextEditingController emailcon = TextEditingController();
  TextEditingController passwordcon = TextEditingController();

  // var toursList = <ToursModel>[].obs;
  // var guidesList = <GuidesModel>[].obs;
  // var blogsHomeList = <BlogData>[].obs;
  var blogsList = <BlogData>[].obs;

  var loading = false.obs;

  Map<String, String>? headers = {
    "Content-Type":"application/json",
    "Authorization": "Bearer ${SharedPref.read("accessToken")}"
  };

  @override
  void onInit() {
    super.onInit();
    fetchall();
  }


  fetchall() async {
    getHome();
    clearAll();
  }

  clearAll() {
    initialPage.value = 1;
    // toursList.clear();
    // blogsHomeList.clear();
    // guidesList.clear();
    blogsList.clear();
  }

  late HomeModel homedata;
  Future getHome() async {
    loading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/home", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    ).whenComplete(() => loading(false));
    homedata = HomeModel.fromMap(data);
  }


  var paginationloading = false.obs;
  Future getBlogsLoadMore() async {
    paginationloading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/blog/?limit=8&page=${initialPage.value}", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    );
    initialPage.value++;
    List listdata = data['data'];
    List moreblogsList = listdata.map((e) => BlogData.fromMap(e)).toList();
    for (var i = 0; i < moreblogsList.length; i++) {
      blogsList.add(moreblogsList[i]);
    }
    blogsList.toSet();
    paginationloading(false);
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

  late ToursModel tour;
  var tourloading = false.obs;
  Future getTourById(id) async {
    tourloading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/tours/$id", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    ).whenComplete(() => tourloading(false));
    tour = ToursModel.fromMap(data);
  }


  late GuidesModel guide;
  var guideloading = false.obs;
  Future getGuideById(id) async {
    guideloading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/guides/$id", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    ).whenComplete(() => guideloading(false));
    guide = GuidesModel.fromMap(data);
  }

  var locationLoading = false.obs;
  Future getLocation() async {
    locationLoading(true);
    final loca = await LocationHelper().getLocation();
    var data = await handleRequest(method: "get", url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=${loca?.latitude},${loca?.longitude}&result_type=locality&key=AIzaSyCAXHaJF6ZAnU7OB46NBzQvY0_HFS73Olc");
    if(data !=null) {
      debugPrint("City:${data['results'][0]['address_components'].first['long_name']}");
      debugPrint("Country:${data['results'][0]['address_components'].last['long_name']}");
      debugPrint("Region:${data['results'][0]['address_components'][2]['long_name']}");
      await updateUserLocation(
        city: data['results'][0]['address_components'].first['long_name'],
        country: data['results'][0]['address_components'].last['long_name'],
        region: data['results'][0]['address_components'].last['long_name'],
      );
    }
  }

  final profileCon = Get.put(ProfileController());

  Future updateUserLocation({country, city, region}) async {
    await handleRequest(method: "put", url: "${baseUrl}api/users/${SharedPref.read('id')}", headers: headers,
      body: {
        "location" : {
          "country": country,
          "city": city,
          "region": region
        }
      }
    );
    await profileCon.getUserById();
    locationLoading(false);
  }


  //bloglist
  var initialPage = 1.obs;

  //blog details
  var isAppbarvisible = false.obs;
  var appbarOffset = const Offset(10, 0).obs;
}