
import 'package:findmyguide/models/user_model.dart';
import 'package:findmyguide/utils/dialog_boxes.dart';
import 'package:findmyguide/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  var loading = false.obs;

  late UserModel user;

  Future getUserById() async {
    loading(true);
    var data = await handleRequest(
      method: "get", 
      url: "${baseUrl}api/users/678800991c25da6c9a9dfa7e", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
    ).whenComplete(() => loading(false));

    user = UserModel.fromMap(data);
    username.text = user.username.toString();
    
  }


  Future updateUserById() async {
    loadingDialog();
    Map<String, dynamic> body = {
        "username": username.text
    };

    await handleRequest(
      method: "put", 
      url: "${baseUrl}api/users/678800991c25da6c9a9dfa7e", 
      headers: {
        "Content-Type":"application/json",
        "Authorization": "Bearer ${SharedPref.read("accessToken")}"
      },
      body: body
    ).then((v) async {
      await getUserById();
      Get.back();
      Get.back();
      customsnackBar(message: "Successfully updated");
    });
    
  }

  Future logout() async {
    SharedPref.remove("accessToken");
    SharedPref.remove("email");
    SharedPref.remove("password");
    Get.offAll(() => const LoginView());
  }
}