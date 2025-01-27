


import 'dart:convert';

import 'package:findmyguide/constants/url_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/dialog_boxes.dart';

class RegisterController extends GetxController{
  TextEditingController emailcon = TextEditingController();
  TextEditingController passwordcon = TextEditingController();
  TextEditingController usernamecon = TextEditingController();
  TextEditingController phonecon = TextEditingController();
  TextEditingController dobcon = TextEditingController();


  @override
  void onInit() {
    super.onInit();

  }
  var profileImg = "".obs;

  Future register() async {
    Map<String, String> body = {
        "username": usernamecon.text,
        "mobile_no": phonecon.text,
        "dob": dobcon.text,
        "email": emailcon.text,
        "password": passwordcon.text,
    };

    var req = http.MultipartRequest("POST", Uri.parse("${baseUrl}api/users"));
    req.headers.addAll({
        "Content-Type":"application/json",
    });
    req.fields.addAll(body);
    if(profileImg.value !="") {
      req.files.add(await http.MultipartFile.fromPath('image', profileImg.value));
    }

    var response = await req.send();
    var responsed = await http.Response.fromStream(response);
    final responsedData = jsonDecode(responsed.body);
    if(responsed.statusCode >= 200 && responsed.statusCode <= 300){
      Get.back();
      customsnackBar(message: "Registration Successfull");
    } else {
      customsnackBar(message: responsedData['message'].toString());
    }
  }

}