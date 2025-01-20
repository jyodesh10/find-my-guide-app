


import 'package:findmyguide/constants/url_constants.dart';
import 'package:findmyguide/utils/http_handler.dart';
import 'package:findmyguide/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dialog_boxes.dart';
import '../widgets/navbar.dart';

class LoginController extends GetxController{
  TextEditingController emailcon = TextEditingController();
  TextEditingController passwordcon = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    if((SharedPref.read("email").toString().isNotEmpty && SharedPref.read("email").toString()!="null") && (SharedPref.read("password").toString().isNotEmpty && SharedPref.read("password").toString()!="null")) {
      emailcon.text = SharedPref.read("email").toString();
      passwordcon.text = SharedPref.read("password").toString();
      Future.delayed(const Duration(milliseconds: 300), () => loginRequest());
    }
  }

  Future loginRequest() async {
    loadingDialog();
    var data = await handleRequest(
      method: "post", 
      url: "${baseUrl}auth/login", 
      headers: {
        "Content-Type":"application/json"
      },
      body: {
        "email": emailcon.text,
        "password": passwordcon.text
      } 
    );

    SharedPref.write("accessToken", data['accesToken']);
    SharedPref.write("email", emailcon.text);
    SharedPref.write("password", passwordcon.text);
    Get.off(() => const NavBar());
  }

}