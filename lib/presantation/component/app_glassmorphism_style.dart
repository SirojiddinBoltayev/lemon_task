import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';


class AppGlassMorphism extends StatelessWidget {
  const AppGlassMorphism(
      {Key? key,
        required this.child,
        this.blur,
        this.opacity,
        this.color,
        this.borderRadius, this.borderDisable})
      : super(key: key);
  final Widget child;
  final bool? borderDisable;
  final double? blur;
  final double? opacity;
  final Color? color;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur ?? 10, sigmaY: blur ?? 10),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              border: borderDisable ?? false ? null : Border.all(
                  color: (color ?? AppColors.white).withOpacity( 0.6),
                  width: 1.4

              ),
              color: (color ?? AppColors.white).withOpacity(opacity ?? 0.2), borderRadius: borderRadius),
          child: child,
        ),
      ),
    );
  }
}