import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/constants/url_constants.dart';
import 'package:findmyguide/controllers/home_controller.dart';
import 'package:findmyguide/utils/date_formatter.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';

class BlogDetailView extends StatefulWidget {
  const BlogDetailView({super.key, required this.id});
  final String id;

  @override
  State<BlogDetailView> createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {

  final controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getBlogById(widget.id);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      appBar: AppBar(
        backgroundColor: primaryClr,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: black,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() => controller.blogloading.isTrue
          ? const LoadingGif()
          : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 15.sp),
                  child: Text(controller.blog.title.toString(), style: titleStyle,),
                ),
                Center(child: SizedBox(height: 60.sp, child: Image.network(dummyImg1))),
                ListTile(
                  leading: CircleAvatar(
                    radius: 18.sp,
                    backgroundColor: greyblue,
                    child: Center(
                      child: Text(controller.blog.author!.toUpperCase().toString()[0], style: titleStyle.copyWith(color: blue),),
                    ),
                  ),
                  title: Text(controller.blog.author.toString(), style: midTextStyle,),
                  subtitle: Text(
                    DateTimeFormatter.formatDate(controller.blog.createdAt.toString()),
                    style: smallTextStyle.copyWith(fontWeight: FontWeight.w600,fontSize: 13.sp, color: greyblueDrkDrk),
                  ),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.sp).copyWith(bottom: 15.sp),
                  child: Text(
                    controller.blog.content.toString(),
                    style: smallTextStyle,
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }

}
