

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextStyle? style;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  const AppText(this.text,{super.key,this.fontWeight,this.color,this.fontSize,this.maxLines,this.overflow, this.textAlign, this.style, this.decoration});

  @override
  Widget build(BuildContext context) {
    return  Text( text,
      style:  style ?? TextStyle(
        color: color ?? Theme.of(context).textTheme.titleLarge?.color,
        fontSize: fontSize?.sp ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontFamily: "Euclid Circular A",
        decoration: decoration ?? TextDecoration.none,
      ),
      maxLines: maxLines ?? 1,
      textWidthBasis: TextWidthBasis.parent,
      overflow: overflow ?? TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
