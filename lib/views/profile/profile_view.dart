import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/views/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/font_constants.dart';
import '../../constants/url_constants.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: Stack(
        children: [
          Image.asset(backgroundImg, fit: BoxFit.cover,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.sp,
              ),
              Center(
                child: CircleAvatar(
                  radius: 35.sp,
                  backgroundImage: const NetworkImage(dummyImg,),
                ),
              ),
              SizedBox(
                height: 12.sp,
              ),
              Text("Ram Pukar", style: titleStyle,),
              Text("rampukar@gmail.com", style: midTextStyle.copyWith(color: greyblueDrkDrk),),
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
                      leading: CircleAvatar(
                        radius: 18.sp,
                        backgroundColor: greyblue, 
                        child: const Icon(Icons.password_rounded, color: greyblueDrkDrk,),
                      ),
                      title: Text("Change Password", style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
                      subtitle: Text("Change you password", style: smallTextStyle,),
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
        ],
      ),
    );
  }
}