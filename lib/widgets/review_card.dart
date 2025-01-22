import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key, required this.image, required this.name, required this.rating, required this.comment});
  final String image;
  final String name;
  final String  rating;
  final String comment;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: white,
      elevation: 10,
      shadowColor: black.withOpacity(0.2),
      child: ListTile(
        minVerticalPadding: 16.sp,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(imageUrl: widget.image, height: 20.sp, width: 20.sp, fit: BoxFit.cover),  
                ),
                SizedBox(
                  width: 12.sp,
                ),
                Text(widget.name, style: subtitleStyle.copyWith(fontWeight: FontWeight.w600),),
              ],
            ),
            SizedBox(
              height: 10.sp,
            )
          ],
        ),
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.readOnly(
              filledIcon: Icons.star_rounded, 
              emptyIcon: Icons.star_border_rounded,
              size: 18.sp,
              initialRating: double.parse(widget.rating),
              maxRating: 5,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text(widget.comment, style: smallTextStyle, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }
}