import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:practise_app/common/theme/app_colors.dart';

/// Professional Food Logo with balanced, elegant letter-spacing.
/// Fixes clustered glyphs with clear, harmonious breathing room between:
/// 'F' <gap 14px> 'o' <gap 8px> 'o' <gap 12px> 'd'
class FoodLogo extends StatelessWidget {
  final double width;
  final double clocheLift;
  final double oPop;

  const FoodLogo({
    super.key,
    this.width = 195,
    this.clocheLift = 0.0,
    this.oPop = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    // Internal aspect ratio is 182 : 100
    final height = width * (100 / 182);

    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _FoodLogoPainter(
          clocheLift: clocheLift,
          oPop: oPop,
          navyColor: AppColors.textPrimary,
          orangeColor: AppColors.primary,
          accentOrange: const Color(0xFFFFB074),
        ),
      ),
    );
  }
}

class _FoodLogoPainter extends CustomPainter {
  final double clocheLift;
  final double oPop;
  final Color navyColor;
  final Color orangeColor;
  final Color accentOrange;

  _FoodLogoPainter({
    required this.clocheLift,
    required this.oPop,
    required this.navyColor,
    required this.orangeColor,
    required this.accentOrange,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Internal coordinate space: 182 x 100
    canvas.save();
    final scale = size.width / 182.0;
    canvas.scale(scale, scale);

    // -----------------------------------------------------------------
    // 1. BASE SPEED / PLATTER DASHES UNDER 'oo'
    // -----------------------------------------------------------------
    final dashPaint = Paint()
      ..color = accentOrange.withOpacity(0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    // Line 1: top short dash on left
    canvas.drawLine(const Offset(68, 77), const Offset(84, 77), dashPaint);
    // Line 2: middle longer platter line spanning both o's
    canvas.drawLine(const Offset(62, 81), const Offset(118, 81), dashPaint);
    // Line 3: bottom short dash on right
    canvas.drawLine(const Offset(86, 85), const Offset(110, 85), dashPaint);

    // -----------------------------------------------------------------
    // 2. LETTER 'F' (Dark Navy, Bold, Rounded)
    // Left: 18, Right: 42
    // -----------------------------------------------------------------
    final navyPaint = Paint()
      ..color = navyColor
      ..style = PaintingStyle.fill;

    // Vertical stem of F
    final fStem = RRect.fromRectAndRadius(
      const Rect.fromLTWH(18, 30, 10.5, 44),
      const Radius.circular(5.2),
    );
    canvas.drawRRect(fStem, navyPaint);

    // Top horizontal bar of F
    final fTopBar = RRect.fromRectAndRadius(
      const Rect.fromLTWH(18, 30, 24, 10),
      const Radius.circular(5.0),
    );
    canvas.drawRRect(fTopBar, navyPaint);

    // Middle horizontal bar of F
    final fMidBar = RRect.fromRectAndRadius(
      const Rect.fromLTWH(18, 48, 18.5, 9.2),
      const Radius.circular(4.6),
    );
    canvas.drawRRect(fMidBar, navyPaint);

    // -----------------------------------------------------------------
    // 3. THE TWO 'o's (Vibrant Orange Doughnuts with Clear Spacing)
    // First 'o': Center (71, 60), radius 13.5 (span: 57.5 .. 84.5)
    // Second 'o': Center (99, 60), radius 13.5 (span: 85.5 .. 112.5)
    // Breathing room: gap between F & o1 = 15.5px, gap between o1 & o2 = 7px
    // -----------------------------------------------------------------
    final oFillPaint = Paint()
      ..color = orangeColor
      ..style = PaintingStyle.fill;

    final oHolePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final oScaleFactor = 0.92 + (0.08 * oPop);

    // First 'o'
    canvas.save();
    canvas.translate(71, 60);
    canvas.scale(oScaleFactor, oScaleFactor);
    canvas.drawCircle(Offset.zero, 13.5, oFillPaint);
    canvas.drawCircle(Offset.zero, 5.5, oHolePaint);
    canvas.restore();

    // Second 'o'
    canvas.save();
    canvas.translate(99, 60);
    canvas.scale(oScaleFactor, oScaleFactor);
    canvas.drawCircle(Offset.zero, 13.5, oFillPaint);
    canvas.drawCircle(Offset.zero, 5.5, oHolePaint);
    canvas.restore();

    // -----------------------------------------------------------------
    // 4. LETTER 'd' (Dark Navy, Bold, Rounded, with Clear Gap from 'o')
    // Bowl Center: (127.5, 60), radius 13.5 (span: 114 .. 141)
    // Breathing room: gap between o2 & d = 11.5px
    // -----------------------------------------------------------------
    canvas.drawCircle(const Offset(127.5, 60), 13.5, navyPaint);
    canvas.drawCircle(const Offset(127.5, 60), 5.5, oHolePaint);

    // Ascender stem of 'd'
    final dStem = RRect.fromRectAndRadius(
      const Rect.fromLTWH(130.5, 30, 10.5, 44),
      const Radius.circular(5.2),
    );
    canvas.drawRRect(dStem, navyPaint);

    // -----------------------------------------------------------------
    // 5. THE CLOCHE SERVING DOME (Lifts & Tilts over the two 'o's)
    // Centered at x = 85.0 (midpoint of 71 & 99)
    // Spans across both 'o's (width = 58)
    // -----------------------------------------------------------------
    canvas.save();

    final liftY = -20.0 * clocheLift;
    final tiltAngle = -0.10 * clocheLift; // ~ -5.7 degrees

    canvas.translate(85.0, 46.0 + liftY);
    canvas.rotate(tiltAngle);

    final clochePaint = Paint()
      ..color = orangeColor
      ..style = PaintingStyle.fill;

    // A. Cloche Dome Body (Width = 54, Height = 23)
    final domePath = Path();
    domePath.moveTo(-26, 0); // bottom left
    domePath.cubicTo(
      -24, -23, // left curve
      24, -23,  // right curve
      26, 0,    // bottom right
    );
    domePath.close();
    canvas.drawPath(domePath, clochePaint);

    // B. Bottom rim bar resting right over the two 'o's
    final rimPaint = Paint()
      ..color = orangeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(-27.5, 0), const Offset(27.5, 0), rimPaint);

    // C. Top Ring / Loop Handle
    final handlePaint = Paint()
      ..color = orangeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      const Rect.fromLTWH(-4.5, -25, 9, 8),
      math.pi,
      math.pi,
      false,
      handlePaint,
    );

    // D. White Shine Highlight Curve
    final shinePaint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final shinePath = Path();
    shinePath.addArc(
      const Rect.fromLTWH(-20, -18, 40, 28),
      math.pi * 1.05,
      math.pi * 0.22,
    );
    canvas.drawPath(shinePath, shinePaint);

    canvas.restore(); // restore cloche transform
    canvas.restore(); // restore global scale
  }

  @override
  bool shouldRepaint(covariant _FoodLogoPainter oldDelegate) {
    return oldDelegate.clocheLift != clocheLift ||
        oldDelegate.oPop != oPop ||
        oldDelegate.navyColor != navyColor ||
        oldDelegate.orangeColor != orangeColor;
  }
}
