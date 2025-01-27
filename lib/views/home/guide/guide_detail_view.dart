import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/home_controller.dart';
import 'package:findmyguide/widgets/custom_cacheimage.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:findmyguide/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/color_constants.dart';

class GuideDetailView extends StatefulWidget {
  const GuideDetailView({super.key, required this.id});
  final String id;

  @override
  State<GuideDetailView> createState() => _GuideDetailViewState();
}

class _GuideDetailViewState extends State<GuideDetailView> {

  final controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getGuideById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => controller.guideloading.isTrue
            ? const LoadingGif()
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.sp,
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: black,
                  ),
                ),
                topSection(),
                bioSection(),
                languageAndSpecializationSection(),
                contactSection(),
                reviewSection()
              ],
            ),
          ),
        )
      ),
      bottomNavigationBar: Obx(() => controller.guideloading.isTrue
        ? const LinearProgressIndicator(color: blue,)
        : Container(
          height: 35.sp,
          color: white,
          child: Row(
            children: [
              SizedBox(
                width: 18.sp,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Price",
                    style: midTextStyle,
                  ),
                  Text(
                    controller.guide.price.toString(),
                    style: titleStyle,
                  )
                ],
              ),
              const Spacer(),
              MaterialButton(
                color: blue,
                height: 28.sp,
                minWidth: 38.w,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
                child: Text("Hire Now", style: midTextStyle.copyWith(color: white),),
                onPressed: () {}),
              SizedBox(
                width: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  topSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(
        //   width: 15.sp,
        // ),
        Container(
          height: 52.sp,
          width: 45.sp,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 5,
                color: black.withOpacity(0.08)
              )
            ],
            border: Border.all(
              color: white,
              width: 6
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.sp),
            child: CustomCachedNetworkImage(
              imageUrl: controller.guide.image.toString(), 
              fit: BoxFit.cover,
              height: 52.sp,
              width: 45.sp,
            ),
          ),
        ),
        SizedBox(
          width: 15.sp,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${controller.guide.firstname} ${controller.guide.lastname}", style: titleStyle,),
              Text("${controller.guide.location!.city}, ${controller.guide.location!.country} ", style: midTextStyle,),
              Text("Since ${DateTime.now().year-controller.guide.experience!.toInt()}", style: midTextStyle,),
              SizedBox(
                height: 12.sp,
              ),
              Row(
                children: [
                  verifiedTile(controller.guide.isVerified),
                  SizedBox(
                    width: 15.sp,
                  ),
                  controller.guide.isVerified == true 
                    ? const Icon(Icons.document_scanner_rounded, color: blue,)
                    : const SizedBox()
                ],
              ),
              SizedBox(
                height: 12.sp,
              ),
              RatingBar.readOnly(
                filledIcon: Icons.star_rounded, 
                emptyIcon: Icons.star_border_rounded,
                size: 20.sp,
                initialRating: double.parse(controller.guide.rating.toString()),
                maxRating: 5,
              ),
            ],
          ),
        )
      ],
    );
  }
  
  bioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Bio", style: titleStyle.copyWith(fontSize: 16.sp),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Text(
            controller.guide.bio.toString(),
            style: smallTextStyle,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
  
  languageAndSpecializationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Languages", style: titleStyle.copyWith(fontSize: 16.sp),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Wrap(
            runSpacing: 10.sp,
            spacing: 10.sp,
            children: List.generate(controller.guide.languages!.length, (index) {
              return Chip(
                label: Text(controller.guide.languages![index], style: subtitleStyle,),
                backgroundColor: greyblue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
                side: const BorderSide(style: BorderStyle.none),
              );
            })
          )
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Specializations", style: titleStyle.copyWith(fontSize: 16.sp),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Wrap(
            runSpacing: 10.sp,
            spacing: 10.sp,
            children: List.generate(controller.guide.specializations!.length, (index) {
              return Chip(
                label: Text(controller.guide.specializations![index], style: subtitleStyle,),
                backgroundColor: greyblue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
                side: const BorderSide(style: BorderStyle.none),
              );
            })
          )
        )
      ],
    );
  }

  contactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Contacts", style: titleStyle.copyWith(fontSize: 16.sp),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Email", style: subtitleStyle,),
                  SelectableText(controller.guide.email.toString(), style: subtitleStyle.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
              Divider(
                color: black.withOpacity(0.1),
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Phone", style: subtitleStyle,),
                  SelectableText(controller.guide.phone.toString(), style: subtitleStyle.copyWith(fontWeight: FontWeight.bold))
                ],
              ),
              Divider(
                color: black.withOpacity(0.1),
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Website", style: subtitleStyle,),
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse(controller.guide.website.toString()))) {
                        throw Exception('Could not launch ${controller.guide.website.toString()}}');
                      }
                    },
                    child: Text(controller.guide.website.toString(), style: subtitleStyle.copyWith(fontWeight: FontWeight.bold))
                  )
                ],
              ),
              Divider(
                color: black.withOpacity(0.1),
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Facebook", style: subtitleStyle,),
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse(controller.guide.facebook.toString()))) {
                        throw Exception('Could not launch ${controller.guide.facebook.toString()}}');
                      }
                    },
                    child: Text(controller.guide.facebook.toString(), style: subtitleStyle.copyWith(fontWeight: FontWeight.bold))
                  )                
                ],
              ),
              Divider(
                color: black.withOpacity(0.1),
                thickness: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Whatsapp", style: subtitleStyle,),
                  InkWell(
                    onTap: () async {
                      if (!await launchUrl(Uri.parse(controller.guide.whatsapp.toString()))) {
                        throw Exception('Could not launch ${controller.guide.whatsapp.toString()}}');
                      }
                    },
                    child: Text(controller.guide.whatsapp.toString(), style: subtitleStyle.copyWith(fontWeight: FontWeight.bold))
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
  
  reviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp).copyWith(bottom: 10.sp, top: 15.sp),
          child: Text("Reviews", style: titleStyle.copyWith(fontSize: 16.sp),),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp),
          child: Column(
            children: List.generate(controller.guide.reviews!.length, (index) {
              return ReviewCard(
                image: controller.guide.reviews![index].user!.image.toString(), 
                name: controller.guide.reviews![index].user!.username.toString(), 
                rating: controller.guide.reviews![index].rating.toString(), 
                comment: controller.guide.reviews![index].comment.toString()
              );
            })
          ),
        )
      ],
    );
  }
  
  verifiedTile(bool? isVerified) {
    return Container(
      height: 20.sp,
      // width: 26.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp),
        border: Border.all(color: isVerified! ? green : red, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 6.sp,
          ),
          CircleAvatar(
            radius: 12.sp,
            backgroundColor: isVerified? green : red,
            child: Icon(isVerified ? Icons.check : Icons.close, color: white, size: 15.sp,),
          ),
          SizedBox(
            width: 8.sp,
          ),
          Text(isVerified ? "Verified" : "Not verified", style: smallTextStyle.copyWith(color:isVerified ? green : red, fontWeight: FontWeight.bold),),
          SizedBox(
            width: 10.sp,
          ),
        ],
      ),
    );
  }

}
