


import 'package:findmyguide/constants/url_constants.dart';
import 'package:findmyguide/utils/http_handler.dart';
import 'package:findmyguide/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/navbar.dart';

class LoginController extends GetxController{
  TextEditingController emailcon = TextEditingController();
  TextEditingController passwordcon = TextEditingController();

  Future loginRequest() async {
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