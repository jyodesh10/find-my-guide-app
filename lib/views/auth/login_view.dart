import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/login_controller.dart';
import 'package:findmyguide/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    if(SharedPref.read("email").toString().isNotEmpty && SharedPref.read("password").toString().isNotEmpty) {
      controller.emailcon.text = SharedPref.read("email").toString();
      controller.passwordcon.text = SharedPref.read("password").toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: Container(
        margin: EdgeInsets.all(20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.emailcon,
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: white,
                filled: true,
                hintText: "Email",
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            TextField(
              controller: controller.passwordcon,
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: white,
                filled: true,
                hintText: "Passowrd",
              ),
            ),
            SizedBox(
              height: 20.sp,
            ),
            MaterialButton(
              color: greyblue,
              minWidth: 50.w,
              height: 26.sp,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Text("Login", style: subtitleStyle,),
              onPressed: (){
                controller.loginRequest();
              })
          ],
        ),
      ),
    );
  }
}