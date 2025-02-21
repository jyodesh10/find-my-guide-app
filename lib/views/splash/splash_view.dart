import 'package:findmyguide/utils/shared_pref.dart';
import 'package:findmyguide/views/walkthrough/roleselection_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../auth/login_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
      if(SharedPref.read("isFirstTime").toString() != "null"/*  || SharedPref.read("isFirstTime") != true  */) {
        Future.delayed(const Duration(seconds: 1), ()=> Get.off(() => const LoginView()));
      } else {
        Future.delayed(const Duration(seconds: 1), ()=> Get.off(() => const RoleSelectionView()));
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: Center(
        child: Text("Find My Guide", style: titleStyle,),
      )
    );
  }
}