import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class GradientOutlineInputBorder extends InputBorder {
  const GradientOutlineInputBorder({
    required this.gradient,
    this.width = 1.0,
    this.gapPadding = 4.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.height,
  });

  final double width;
  final BorderRadius borderRadius;
  final Gradient gradient;
  final double gapPadding;
  final double? height; // Foydalanuvchi kiritadigan balandlik.

  @override
  InputBorder copyWith({BorderSide? borderSide}) {
    return this;
  }

  @override
  bool get isOutline => true;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRRect(
        borderRadius
            .resolve(textDirection)
            .toRRect(rect)
            .deflate(borderSide.width),
      );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  void paint(
      Canvas canvas,
      Rect rect, {
        double? gapStart,
        double gapExtent = 0.0,
        double gapPercentage = 0.0,
        TextDirection? textDirection,
      }) {
    // Foydalanuvchi belgilagan `height` ni qo‘llash va markazlash
    final adjustedRect = height != null
        ? Rect.fromLTWH(
      rect.left,
      rect.top + (rect.height - height!) / 35, // To'g'ri markazlash
      rect.width,
      height!,
    )
        : rect;

    final paint = _getPaint(adjustedRect);
    final outer = borderRadius.toRRect(adjustedRect);
    final center = outer.deflate(width / 2.0);

    if (gapStart == null || gapExtent <= 0.0 || gapPercentage == 0.0) {
      canvas.drawRRect(center, paint);
    } else {
      final extent =
      lerpDouble(0.0, gapExtent + gapPadding * 2.0, gapPercentage)!;
      switch (textDirection!) {
        case TextDirection.rtl:
          final path = _gapBorderPath(
            canvas,
            center,
            math.max(10, gapStart + gapPadding - extent),
            extent,
          );
          canvas.drawPath(path, paint);
          break;

        case TextDirection.ltr:
          final path = _gapBorderPath(
            canvas,
            center,
            math.max(0, gapStart - gapPadding),
            extent,
          );
          canvas.drawPath(path, paint);
          break;
      }
    }
  }

  @override
  ShapeBorder scale(double t) {
    return GradientOutlineInputBorder(
      width: width * t,
      borderRadius: borderRadius * t,
      gradient: gradient,
      height: height != null ? height! * t : null,
    );
  }

  Paint _getPaint(Rect rect) {
    return Paint()
      ..strokeWidth = width
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke;
  }

  Path _gapBorderPath(
      Canvas canvas,
      RRect center,
      double start,
      double extent,
      ) {
    final scaledRRect = center.scaleRadii();

    final path = Path();
    path.addRRect(scaledRRect);
    return path;
  }
}
