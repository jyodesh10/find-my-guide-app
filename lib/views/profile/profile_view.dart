import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/controllers/profile_controller.dart';
import 'package:findmyguide/views/profile/edit_profile.dart';
import 'package:findmyguide/widgets/custom_cacheimage.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/font_constants.dart';
import '../../constants/url_constants.dart';
import '../../widgets/custom_textfield.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(backgroundImg, fit: BoxFit.cover,),
          Obx(() => controller.loading.isTrue
            ? const LoadingGif()
            : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.sp,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 35.sp,
                      backgroundColor: greyblueDrk,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CustomCachedNetworkImage(imageUrl: controller.user.image.toString(), height: 46.5.sp, width: 46.5.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.sp,
                  ),
                  Text(controller.user.username.toString(), style: titleStyle,),
                  Text(controller.user.email.toString(), style: midTextStyle.copyWith(color: greyblueDrkDrk),),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Card(
                    color: white,
                    margin: EdgeInsets.symmetric(horizontal: 18.sp),
                    elevation: 10,
                    shadowColor: black.withOpacity(0.2),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 18.sp,
                            backgroundColor: greyblue, 
                            child: const Icon(Icons.person_rounded, color: greyblueDrkDrk,),
                          ),
                          title: Text("My Profile", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
                          subtitle: Text("Manage your profile", style: smallTextStyle,),
                          trailing:  const Icon(Icons.chevron_right_rounded, color: greyblueDrkDrk,),
                          onTap: () => Get.to(() => const EditProfileView()),
                        ),
                        ListTile(
                          onTap: () {
                            changePasswordBottomsheet(context);
                          },
                          leading: CircleAvatar(
                            radius: 18.sp,
                            backgroundColor: greyblue, 
                            child: const Icon(Icons.password_rounded, color: greyblueDrkDrk,),
                          ),
                          title: Text("Change Password", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
                          subtitle: Text("Change your password", style: smallTextStyle,),
                          trailing:  const Icon(Icons.chevron_right_rounded, color: greyblueDrkDrk,),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 18.sp,
                            backgroundColor: greyblue, 
                            child: const Icon(Icons.logout_rounded, color: greyblueDrkDrk,),
                          ),
                          title: Text("Log Out", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
                          subtitle: Text("Sign out from app", style: smallTextStyle,),
                          trailing:  const Icon(Icons.chevron_right_rounded, color: greyblueDrkDrk,),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          onTap: () {
                            controller.logout();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 18.sp),
                    child: Text("More", style: midTextStyle,),
                  ),
                  SizedBox(
                    height: 12.sp,
                  ),
                  Card(
                    color: white,
                    margin: EdgeInsets.symmetric(horizontal: 18.sp),
                    elevation: 10,
                    shadowColor: black.withOpacity(0.2),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 18.sp,
                            backgroundColor: greyblue, 
                            child: const Icon(Icons.person_rounded, color: greyblueDrkDrk,),
                          ),
                          title: Text("Help & Support", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
                          subtitle: Text("Need help?", style: smallTextStyle,),
                          trailing:  const Icon(Icons.chevron_right_rounded, color: greyblueDrkDrk,),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 18.sp,
                            backgroundColor: greyblue, 
                            child: const Icon(Icons.password_rounded, color: greyblueDrkDrk,),
                          ),
                          title: Text("About App", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
                          subtitle: Text("See information", style: smallTextStyle,),
                          trailing:  const Icon(Icons.chevron_right_rounded, color: greyblueDrkDrk,),
                        ),
                      ],
                    ),
                  ),
                ]
              ),
            ),
          )
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  void changePasswordBottomsheet(BuildContext context) {
    TextEditingController password = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: primaryClr
            ),
            child:Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  Divider(
                    color: black.withOpacity(0.3),
                    height: 15.sp,
                    thickness: 3,
                    endIndent: 40.w,
                    indent: 40.w,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 10.sp),
                    child: Text("Password", style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),),
                  ),
                  CustomTextfield(
                    hintText: "New Password",
                    controller: password,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                    child: Text("Confirm Password", style: smallTextStyle.copyWith(fontWeight: FontWeight.bold),),
                  ),
                  CustomTextfield(
                    hintText: "Re-type new Password",
                    controller: confirmpassword,
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Center(
                    child: MaterialButton(
                      color: blue,
                      height: 28.sp,
                      minWidth: 38.w,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
                      child: Text("Confirm", style: midTextStyle.copyWith(color: white),),
                      onPressed: () async {
                        if(confirmpassword.text.isNotEmpty) {
                          if(confirmpassword.text == password.text) {
                            Get.back();
                            await controller.changepassword(password.text);
                          } else {
                            Fluttertoast.showToast(msg: "Passwords doesn't match");
                          }
                        } else {
                          Fluttertoast.showToast(msg: "Password is required");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                ],
              ),
            )
          ),
        );
      },
    );
  }

}