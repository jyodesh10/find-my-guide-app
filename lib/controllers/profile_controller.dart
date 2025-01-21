
import 'dart:convert';

import 'package:findmyguide/models/user_model.dart';
import 'package:findmyguide/utils/date_formatter.dart';
import 'package:findmyguide/utils/dialog_boxes.dart';
import 'package:findmyguide/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/url_constants.dart';
import '../utils/http_handler.dart';
import '../utils/shared_pref.dart';


class ProfileController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    getUserById();
    
  }

  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  var profileImg = "".obs;

  var loading = false.obs;

  late UserModel user;

  Future getUserById() async {
    loading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/users/${SharedPref.read("id")}", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    ).whenComplete(() => loading(false));

    user = UserModel.fromMap(data);
    username.text = user.username.toString();
    phone.text = user.mobileNo.toString();
    dob.text = DateTimeFormatter.formatDate(user.dob.toString());
    profileImg.value = "";    
  }


  Future updateUserById() async {
    loadingDialog();
    Map<String, String> body = {
        "username": username.text,
        "mobile_no": phone.text,
        "dob": dob.text,
        // "image": profileImg.value !=""
        //   ? MultipartFile(profileImg.value, filename: "${SharedPref.read("id")}")
        //   : user.image.toString()
    };

    var req = http.MultipartRequest("PUT", Uri.parse("${baseUrl}api/users/${SharedPref.read('id')}"));
    req.headers.addAll({
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
    });
    req.fields.addAll(body);
    if(profileImg.value !="") {
      req.files.add(await http.MultipartFile.fromPath('image', profileImg.value));
    }

    var response = await req.send();
    var responsed = await http.Response.fromStream(response);
    final responsedData = jsonDecode(responsed.body);
    
    if(responsed.statusCode == 200){
      await getUserById();
      Get.back();
      Get.back();
      customsnackBar(message: "Successfully updated");
    } else {
      Get.back();
      customsnackBar(message: responsedData['message'].toString());

    }
    // await handleRequest(
    //   method: "put", 
    //   url: "${baseUrl}api/users/678800991c25da6c9a9dfa7e", 
    //   headers: {
    //     "Content-Type":"application/json",
    //     "Authorization": "Bearer ${SharedPref.read("accessToken")}"
    //   },
    //   body: body
    // ).then((v) async {
    //   await getUserById();
    //   Get.back();
    //   Get.back();
    //   customsnackBar(message: "Successfully updated");
    // });
    
  }

  Future logout() async {
    SharedPref.remove("accessToken");
    SharedPref.remove("email");
    SharedPref.remove("password");
    SharedPref.remove("id");
    Get.offAll(() => const LoginView());
  }
}