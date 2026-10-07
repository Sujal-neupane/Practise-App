import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:practise_app/common/theme/app_colors.dart';

/// Renders the elegant circular fan pattern in the corners matching Screen 2 of the design.
class SplashRaysPainter extends CustomPainter {
  final double progress;
  final Color orangeColor;
  final Color greyColor;

  SplashRaysPainter({
    required this.progress,
    this.orangeColor = AppColors.splashRaysOrange,
    this.greyColor = AppColors.splashRaysGrey,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    // -------------------------------------------------------------
    // 1. TOP-LEFT FAINT GREY FAN
    // -------------------------------------------------------------
    final topLeftOrigin = const Offset(0, 0);
    final double greyOuterRadius = size.width * 0.40 * progress;
    final double greyInnerRadius = 20.0;
    const int greyRayCount = 13;

    final greyPaint = Paint()
      ..color = greyColor.withOpacity(progress * 0.70)
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Save and clip to the outer arc boundary
    canvas.save();
    for (int i = 0; i < greyRayCount; i++) {
      final angle = (i / (greyRayCount - 1)) * (math.pi / 2.08) + 0.04;
      final p1 = Offset(
        topLeftOrigin.dx + greyInnerRadius * math.cos(angle),
        topLeftOrigin.dy + greyInnerRadius * math.sin(angle),
      );
      final p2 = Offset(
        topLeftOrigin.dx + greyOuterRadius * math.cos(angle),
        topLeftOrigin.dy + greyOuterRadius * math.sin(angle),
      );
      canvas.drawLine(p1, p2, greyPaint);
    }
    canvas.restore();

    // -------------------------------------------------------------
    // 2. BOTTOM-RIGHT VIBRANT ORANGE CIRCULAR FAN
    // Exactly matches the circular fan arc in the design
    // -------------------------------------------------------------
    final bottomRightOrigin = Offset(size.width, size.height);
    final double orangeOuterRadius = size.width * 0.68 * progress;
    final double orangeInnerRadius = 32.0;
    const int orangeRayCount = 17;

    // Fan rays span from ~182 degrees (pointing left) to ~268 degrees (pointing up)
    const double startAngle = math.pi + 0.04;
    const double endAngle = (1.5 * math.pi) - 0.04;

    canvas.save();

    for (int i = 0; i < orangeRayCount; i++) {
      final t = i / (orangeRayCount - 1);
      final angle = startAngle + t * (endAngle - startAngle);

      final p1 = Offset(
        bottomRightOrigin.dx + orangeInnerRadius * math.cos(angle),
        bottomRightOrigin.dy + orangeInnerRadius * math.sin(angle),
      );
      final p2 = Offset(
        bottomRightOrigin.dx + orangeOuterRadius * math.cos(angle),
        bottomRightOrigin.dy + orangeOuterRadius * math.sin(angle),
      );

      final rayPaint = Paint()
        ..color = orangeColor.withOpacity(progress.clamp(0.0, 1.0))
        ..strokeWidth = 4.2
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawLine(p1, p2, rayPaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SplashRaysPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
