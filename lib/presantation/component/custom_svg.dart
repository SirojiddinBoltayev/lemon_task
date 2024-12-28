



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors/app_colors.dart';

class AppCustomSvgWidgetAsset extends StatelessWidget {
  // final double? width;
  final double? height;
  final double? width;
  final double? size;
  final Color? color;
  final BlendMode? blendMode;
  final String path;
  final BoxFit? fit;
  final bool defaultColor;

  const AppCustomSvgWidgetAsset(this.path,
      {super.key, this.size, this.color, this.blendMode, this.defaultColor = false, this.fit, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path,
        width: width ?? size?.sp ?? 20.sp,
        height: height ?? size?.sp ?? 20.sp,
        fit: fit ?? BoxFit.scaleDown,

        colorFilter: defaultColor
            ? null
            : ColorFilter.mode(
                color ?? AppColors.cF5F5F5, blendMode ?? BlendMode.srcIn));
  }
}
