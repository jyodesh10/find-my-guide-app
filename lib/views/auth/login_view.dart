import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/login_controller.dart';
import 'package:findmyguide/utils/dialog_boxes.dart';
import 'package:findmyguide/views/auth/register_view.dart';
import 'package:findmyguide/widgets/custom_textfield.dart';
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
  final  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: Container(
        margin: EdgeInsets.all(20.sp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextfield(
                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                controller: controller.emailcon,
                hintText: "Email",
              ),
              SizedBox(
                height: 20.sp,
              ),
              CustomTextfield(
                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                controller: controller.passwordcon,
                hintText: "Password",
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
                  if(controller.emailcon.text=="" || controller.passwordcon.text=="" ) {
                    customsnackBar(message: "Empty Fields", backgroundColor: red.withOpacity(0.2));
                  } else {
                    controller.loginRequest();
                  }
                }
              ),
              MaterialButton(
                color: greyblue,
                minWidth: 50.w,
                height: 26.sp,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Register", style: subtitleStyle,),
                onPressed: (){
                  Get.to(()=> RegisterView());
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}