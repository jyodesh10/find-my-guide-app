import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/controllers/home_controller.dart';
import 'package:findmyguide/models/blogs_model.dart';
import 'package:findmyguide/utils/date_formatter.dart';
import 'package:findmyguide/views/home/blog_detail_view.dart';
import 'package:findmyguide/widgets/custom_appbar.dart';
import 'package:findmyguide/widgets/custom_cacheimage.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/font_constants.dart';

class BloglistView extends StatefulWidget {
  const BloglistView({super.key});

  @override
  State<BloglistView> createState() => _BloglistViewState();
}

class _BloglistViewState extends State<BloglistView> {
  
  final controller = Get.put(HomeController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
      controller.initialPage.value = 1;
      controller.getBlogsLoadMore();
    _scrollController.addListener(() {
      debugPrint(_scrollController.offset.toString());
      if(_scrollController.offset >= (_scrollController.position.maxScrollExtent)) {
        debugPrint("This is th end");
        controller.getBlogsLoadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.blogsList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      appBar: customAppbar(title: "Blogs"),
      body: CustomScrollView(
        controller: _scrollController,
        // physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Obx(() => 
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 15.sp),
                  itemBuilder: (context, index) {
                    BlogData blog = controller.blogsList[index];
                    return blogTile(
                      blog: blog
                    );
                  }, 
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 15.sp,
                    );
                  }, 
                  itemCount: controller.blogsList.length
                  ),
                ),
                Obx(() => controller.paginationloading.isTrue
                  ? const LoadingGif()
                  : SizedBox(
                    height: 30.sp,
                  )
                ),
                SizedBox(
                  height: 15.sp,
                )
              ],
            ),
          )
        ]
      ),
    );
  }

  blogTile({required BlogData blog }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.sp),
      child: InkWell(
        onTap: () => Get.to(() => BlogDetailView(id: blog.id.toString())),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomCachedNetworkImage(imageUrl: blog.image.toString(), height: 40.sp, width: 28.w,) 
            ),
            SizedBox(
              width: 12.sp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(blog.title.toString(), style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 8.sp,
                  ),
                  Text(DateTimeFormatter.formatDate(blog.createdAt.toString()), style: smallTextStyle.copyWith(color: greyblueDrkDrk, fontWeight: FontWeight.bold),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}