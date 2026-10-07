import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:practise_app/common/theme/app_colors.dart';

/// Professional, pixel-perfect Food Logo crafted with vector precision.
/// Matches the original food delivery brand design with:
/// - Clean, rounded, bold typography for 'F' and 'd'
/// - Two perfect vibrant orange 'o's
/// - Cloche lid with top ring handle & white shine curve that smoothly lifts & tilts
/// - Platter base speed/warmth dashes underneath
class FoodLogo extends StatelessWidget {
  /// Base width of the logo (default ~180 for standard display)
  final double width;

  /// Cloche lift progress (0.0 = resting on o's, 1.0 = lifted up and tilted)
  final double clocheLift;

  /// Bouncy pop of the two "o"s (0.0 to 1.0)
  final double oPop;

  const FoodLogo({
    super.key,
    this.width = 175,
    this.clocheLift = 0.0,
    this.oPop = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    // Aspect ratio of the complete logo artwork is approx 180 : 100
    final height = width * (100 / 180);

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
    // Internal coordinate space: 180 x 100
    canvas.save();
    final scale = size.width / 180.0;
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
    canvas.drawLine(const Offset(62, 77), const Offset(74, 77), dashPaint);
    // Line 2: middle longer dash
    canvas.drawLine(const Offset(57, 81), const Offset(105, 81), dashPaint);
    // Line 3: bottom short dash on right
    canvas.drawLine(const Offset(76, 85), const Offset(98, 85), dashPaint);

    // -----------------------------------------------------------------
    // 2. LETTER 'F' (Dark Navy, Bold, Rounded)
    // -----------------------------------------------------------------
    final navyPaint = Paint()
      ..color = navyColor
      ..style = PaintingStyle.fill;

    // Vertical stem of F
    final fStem = RRect.fromRectAndRadius(
      const Rect.fromLTWH(18, 30, 11, 44),
      const Radius.circular(5.5),
    );
    canvas.drawRRect(fStem, navyPaint);

    // Top horizontal bar of F
    final fTopBar = RRect.fromRectAndRadius(
      const Rect.fromLTWH(18, 30, 26, 10.5),
      const Radius.circular(5.2),
    );
    canvas.drawRRect(fTopBar, navyPaint);

    // Middle horizontal bar of F
    final fMidBar = RRect.fromRectAndRadius(
      const Rect.fromLTWH(18, 48, 20, 9.5),
      const Radius.circular(4.7),
    );
    canvas.drawRRect(fMidBar, navyPaint);

    // -----------------------------------------------------------------
    // 3. THE TWO 'o's (Vibrant Orange Doughnuts)
    // -----------------------------------------------------------------
    final oFillPaint = Paint()
      ..color = orangeColor
      ..style = PaintingStyle.fill;

    final oHolePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Subtle bouncy scale when cloche opens
    final oScaleFactor = 0.90 + (0.10 * oPop);

    // First 'o' (Center: x = 66, y = 59.5, radius = 13.5)
    canvas.save();
    canvas.translate(66, 59.5);
    canvas.scale(oScaleFactor, oScaleFactor);
    canvas.drawCircle(Offset.zero, 13.5, oFillPaint);
    canvas.drawCircle(Offset.zero, 5.5, oHolePaint);
    canvas.restore();

    // Second 'o' (Center: x = 93, y = 59.5, radius = 13.5)
    canvas.save();
    canvas.translate(93, 59.5);
    canvas.scale(oScaleFactor, oScaleFactor);
    canvas.drawCircle(Offset.zero, 13.5, oFillPaint);
    canvas.drawCircle(Offset.zero, 5.5, oHolePaint);
    canvas.restore();

    // -----------------------------------------------------------------
    // 4. LETTER 'd' (Dark Navy, Bold, Rounded)
    // -----------------------------------------------------------------
    // Bowl of 'd' (Matching 'o' circular geometry)
    canvas.drawCircle(const Offset(120, 59.5), 13.5, navyPaint);
    canvas.drawCircle(const Offset(120, 59.5), 5.5, oHolePaint);

    // Ascender stem of 'd'
    final dStem = RRect.fromRectAndRadius(
      const Rect.fromLTWH(123, 30, 11, 44),
      const Radius.circular(5.5),
    );
    canvas.drawRRect(dStem, navyPaint);

    // -----------------------------------------------------------------
    // 5. THE CLOCHE SERVING DOME (Lifts up & tilts during animation)
    // -----------------------------------------------------------------
    canvas.save();

    // Cloche resting center is x = 79.5, y = 44
    // When lifted: moves up by up to 18px and tilts by -8 degrees
    final liftY = -18.0 * clocheLift;
    final tiltAngle = -0.12 * clocheLift; // ~ -7 degrees

    canvas.translate(79.5, 45.0 + liftY);
    canvas.rotate(tiltAngle);

    final clochePaint = Paint()
      ..color = orangeColor
      ..style = PaintingStyle.fill;

    // A. Cloche Dome Body (Width = 50, Height = 22)
    final domePath = Path();
    domePath.moveTo(-24, 0); // bottom left
    // Smooth dome arc to bottom right
    domePath.cubicTo(
      -22, -22, // left shoulder
      22, -22,  // right shoulder
      24, 0,    // bottom right
    );
    domePath.close();
    canvas.drawPath(domePath, clochePaint);

    // B. Bottom rim bar (rests right above the two 'o's)
    final rimPaint = Paint()
      ..color = orangeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(-25, 0), const Offset(25, 0), rimPaint);

    // C. Top Ring / Loop Handle
    final handlePaint = Paint()
      ..color = orangeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      const Rect.fromLTWH(-4.5, -23.5, 9, 8),
      math.pi,
      math.pi,
      false,
      handlePaint,
    );

    // D. White Shine Highlight Curve (as seen in original logo)
    final shinePaint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final shinePath = Path();
    shinePath.addArc(
      const Rect.fromLTWH(-19, -17, 38, 26),
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
