import 'package:findmyguide/controllers/wishlist_controller.dart';
import 'package:findmyguide/models/wishlist_model.dart';
import 'package:findmyguide/views/home/tour/tour_detail_view.dart';
import 'package:findmyguide/widgets/custom_appbar.dart';
import 'package:findmyguide/widgets/custom_cacheimage.dart';
import 'package:findmyguide/widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/font_constants.dart';
import '../../widgets/empty_widget.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {

  final controller = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryClr,
      appBar: customAppbar(title: "Wishlist", hasLeading: false),
      body: Obx(() => controller.loading.isTrue
        ? const LoadingGif()
        : controller.wishlistdata.wishlist!.isNotEmpty 
          ? ListView.separated(
            itemCount: controller.wishlistdata.wishlist!.length,
            // shrinkWrap: true,
            itemBuilder: (context, index) {
              Wishlist wishlist = controller.wishlistdata.wishlist![index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 18.sp),
                child: InkWell(
                  onTap: () => Get.to(()=> TourDetailView(id: wishlist.tour!.id.toString())),
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomCachedNetworkImage(imageUrl: wishlist.tour!.image!.first.toString(), fit: BoxFit.cover, height: 40.sp, width: 28.w,),
                      ),
                      SizedBox(
                        width: 12.sp,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(wishlist.tour!.title.toString(), style: midTextStyle.copyWith(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 6.sp,
                            ),
                            Text(wishlist.tour!.price.toString(), style: smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: blue),),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: ()=> controller.deleteWishlistbyId(wishlist.id.toString()), 
                                child: Text("Remove", style: smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: red),)
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 18.sp,
                thickness: 1.5,
                color: black.withOpacity(0.1),
                endIndent: 15.sp,
                indent: 15.sp,
              );
            }, 
          )
          : const EmptyWidget()
      ) 
    );
  }
}
