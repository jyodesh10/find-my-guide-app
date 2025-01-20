

import 'package:findmyguide/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingGif extends StatefulWidget {
  const LoadingGif({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  State<LoadingGif> createState() => _LoadingGifState();
}

class _LoadingGifState extends State<LoadingGif> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(loadingGif, height: widget.height ?? 30.sp, width: widget.height ?? 30.sp,));
  }
}