import 'dart:io';

import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/widgets/custom_textfield.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/url_constants.dart';
import '../../controllers/profile_controller.dart';
import '../../utils/date_picker.dart';
import '../../widgets/custom_cacheimage.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {

  final controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1), (){
      controller.getUserById();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(backgroundImg, fit: BoxFit.cover,),
          SafeArea(
            child: Obx(()=> controller.loading.isTrue
              ? const LoadingGif()
              : Column(
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  profilePicSection(),
                  formSection()
                ],
              )
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Obx(()=> controller.profileImg.value !=""
              ? Image.file(File(controller.profileImg.toString()), fit: BoxFit.cover, height: 42.sp, width: 42.sp,)
              : CustomCachedNetworkImage(imageUrl: controller.user.image.toString(), fit: BoxFit.cover,height: 42.sp, width: 42.sp),
          
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
          child: Text("Upload new picture", style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),)
        ),
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
        CustomTextfield(
          hintText: "username",
          controller: controller.username,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.sp, bottom: 10.sp),
          child: Text("Phone", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
        ),
        CustomTextfield(
          hintText: "phone",
          controller: controller.phone,
          keyboardType: TextInputType.phone,
        ),
        Padding(
          padding: EdgeInsets.only(left: 18.sp, bottom: 10.sp),
          child: Text("Date of birth", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
        ),
        CustomTextfield(
          hintText: "Dob",
          suffixIcon: const Icon(Icons.calendar_month_outlined),
          controller: controller.dob,
          readOnly: true,
          onTap: () async {
            String? pickeddate = await customDatePicker(context);
            if(pickeddate!.isNotEmpty){
              controller.dob.text = pickeddate.toString();
            }
          },
        ),
        Center(
          child: MaterialButton(
            color: blue,
            height: 28.sp,
            minWidth: 38.w,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
            child: Text("Update", style: midTextStyle.copyWith(color: white, fontWeight: FontWeight.bold),),
            onPressed: () {
              controller.updateUserById();
            }
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