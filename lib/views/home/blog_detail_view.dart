import 'package:findmyguide/constants/font_constants.dart';
import 'package:findmyguide/controllers/home_controller.dart';
import 'package:findmyguide/utils/date_formatter.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../widgets/custom_cacheimage.dart';

class BlogDetailView extends StatefulWidget {
  const BlogDetailView({super.key, required this.id});
  final String id;

  @override
  State<BlogDetailView> createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {

  final controller = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();



  @override
  void initState() {
    super.initState();
    controller.getBlogById(widget.id);
    _scrollController.addListener(() {
      if(_scrollController.offset >= 190) {
        controller.appbarOffset.value = Offset.zero;
      } else {
        controller.appbarOffset.value = const Offset(10,0);
      }
    });
    
  }

  @override
  void dispose() {
    super.dispose();
    controller.appbarOffset.value = const Offset(10,0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      body: Obx(() => controller.blogloading.isTrue
        ? const LoadingGif()
        : CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: primaryClr,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: Obx(() =>
                  Icon(
                    Icons.arrow_back_rounded,
                    color: controller.appbarOffset.value == const  Offset(10,0) ? white : black,
                  ),
                ),
              ),
              expandedHeight: 55.sp,
              pinned: true,
              floating: false,
              foregroundColor: primaryClr,
              scrolledUnderElevation: 0.5,
              title: Obx(() => 
                AnimatedSlide(
                  offset: controller.appbarOffset.value,
                  duration: const Duration(milliseconds: 200),
                  child: Text(controller.blog.title.toString(), style: titleStyle, overflow: TextOverflow.ellipsis,)
                )
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    CustomCachedNetworkImage(imageUrl: controller.blog.image.toString(), height: 60.sp, width:  double.infinity,),
                    Container(
                      height: 60.sp,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [black.withOpacity(0.5), white.withOpacity(0.02), transparent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                          stops: const [0, 0.6, 1]
                        )
                      ),
                    ),
                  ],
                ),
              )
            ),
            SliverToBoxAdapter( 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Text(controller.blog.title.toString(), style: titleStyle,),
                  ),
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
            )
          ],
        ),
      ),
    );
  }

}
