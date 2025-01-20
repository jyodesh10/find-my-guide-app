import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/url_constants.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(backgroundImg, fit: BoxFit.cover,),
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 10.sp,
                ),
                profilePicSection(),
                formSection()
              ],
            )
          ),
        ],
      ),
    );
  }
  
  profilePicSection() {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => Get.back(),
              alignment: Alignment.centerLeft,
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: black,
              ),
            ),
            Text("Edit Profile", style: titleStyle,)
          ],
        ),
        Center(
          child: CircleAvatar(
            radius: 30.sp,
            backgroundImage: const NetworkImage(dummyImg,),
          ),
        ),
        TextButton(onPressed: (){}, child: Text("Upload new picture", style: smallTextStyle,)),
      ],
    );
  }
  
  formSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18.sp, bottom: 10.sp),
          child: Text("Username", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
        ),
        const CustomTextfield(hintText: "username"),
        Padding(
          padding: EdgeInsets.only(left: 18.sp, bottom: 10.sp),
          child: Text("Phone", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
        ),
        const CustomTextfield(hintText: "phone"),
        Padding(
          padding: EdgeInsets.only(left: 18.sp, bottom: 10.sp),
          child: Text("Date of birth", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
        ),
        const CustomTextfield(hintText: "Dob"),
        Center(
          child: MaterialButton(
            color: blue,
            height: 28.sp,
            minWidth: 38.w,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
            child: Text("Update", style: midTextStyle.copyWith(color: white, fontWeight: FontWeight.bold),),
            onPressed: () {}
          ),
        ),
        SizedBox(
          height: 40.sp,
        ),
        Center(
          child: MaterialButton(
            color: red,
            height: 28.sp,
            minWidth: 38.w,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
            child: Text("Delete Account", style: midTextStyle.copyWith(color: white, fontWeight: FontWeight.bold),),
            onPressed: () {}
          ),
        ),
      ],
    );
  }
}