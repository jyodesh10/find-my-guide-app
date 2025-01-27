import 'dart:io';

import 'package:findmyguide/controllers/register_controller.dart';
import 'package:findmyguide/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../utils/dialog_boxes.dart';
import '../../widgets/custom_textfield.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      appBar: customAppbar(
        title: ""
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Obx(()=> controller.profileImg.value !=""
                    ? Image.file(File(controller.profileImg.toString()), fit: BoxFit.cover, height: 45.sp, width: 45.sp,)
                    : CircleAvatar(
                      radius: 30.sp,
                    ),
                
                  ) 
                ),
              ),
              TextButton(
                onPressed: ()async{
                  XFile? pickedimg = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if(pickedimg != null){
                    controller.profileImg.value = pickedimg.path;
                  }
                }, 
                child: Text("Upload a picture", style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),)
              ),
              CustomTextfield(
                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                controller: controller.usernamecon,
                hintText: "Username",
              ),
              SizedBox(
                height: 20.sp,
              ),
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
              CustomTextfield(
                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                controller: controller.passwordcon,
                hintText: "Confirm Password",
              ),
              SizedBox(
                height: 20.sp,
              ),
              CustomTextfield(
                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                controller: controller.dobcon,
                hintText: "Date of Birth",
              ),
              SizedBox(
                height: 20.sp,
              ),
              CustomTextfield(
                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                controller: controller.phonecon,
                hintText: "Phone",
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
                child: Text("Register", style: subtitleStyle,),
                onPressed: () async {
                  await controller.register();
                  if(controller.emailcon.text=="" || controller.passwordcon.text=="" ) {
                    customsnackBar(message: "Empty Fields", backgroundColor: red.withOpacity(0.2));
                  } else {
                  }
                })
            ],
          ),
        ),
      ),
    );
  }
}