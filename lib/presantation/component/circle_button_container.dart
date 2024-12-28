
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_colors/app_colors.dart';

class AppCircleButtonContainer extends StatelessWidget {
  const AppCircleButtonContainer(
      {super.key,
      required this.icon,
      this.borderColor,
      required this.onPressed,
      this.isLoading = false,
      this.backgroundColor = const Color(0xFFE9EAEB),
      this.size = 42,
      this.sizeDisable,
      this.padding});

  final Widget icon;
  final EdgeInsets? padding;
  final Function() onPressed;
  final bool isLoading;
  final bool? sizeDisable;
  final Color backgroundColor;
  final double size;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (sizeDisable ?? false) ? null : size.sp,
      width: sizeDisable ?? false ? null : size.sp,
      child: Material(
        borderRadius:
        sizeDisable ?? false ? BorderRadius.circular(60.r) : null,
        shape: sizeDisable ?? false ? null : const CircleBorder(),
        color: backgroundColor,
        clipBehavior: Clip.hardEdge,
        child: Ink(

          height: sizeDisable ?? false ? null : size.h,
          width: sizeDisable ?? false ? null : size.w,
          decoration: sizeDisable ?? false
              ? BoxDecoration(
                  // shape: BoxShape.circle,
                  color: backgroundColor,

                  borderRadius: BorderRadius.circular(60.r),
                )
              : BoxDecoration(
                  shape: BoxShape.circle,
                  color: backgroundColor,
                  border: Border.all(
                    color: borderColor ??AppColors.white.withOpacity(0.1) ?? AppColors.transparent,
                    width: 1.sp,
                  )),
          child: InkWell(
            borderRadius:
                sizeDisable ?? false ? BorderRadius.circular(60.r) : null,
            customBorder: sizeDisable ?? false ? null : const CircleBorder(),
            onTap: () {
              onPressed.call();
            },
            child: Padding(
              padding: (sizeDisable ?? false)
                  ? EdgeInsets.zero
                  : padding ?? EdgeInsets.all(10.sp),
              child: Center(
                child: isLoading ? const CircularProgressIndicator() : icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
