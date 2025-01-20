import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/color_constants.dart';
import '../constants/font_constants.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({super.key});

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
                CircleAvatar(radius: 15.sp,),
                SizedBox(
                  width: 12.sp,
                ),
                Text("Jyodesh", style: midTextStyle,),
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
              initialRating: 4,
              maxRating: 5,
            ),
            SizedBox(
              height: 8.sp,
            ),
            Text("Susan is a great guide. She is extremely knowable abut the history, culture and religion on Nepal. If I ever return I would definitely use her services again. Namaste", style: smallTextStyle, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }
}