import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Creative vector illustration for Onboarding 2:
/// Master chef with hat, apron, steaming stove, cooking pot and sauce bottle.
class Onboard2Illustration extends StatefulWidget {
  final double size;

  const Onboard2Illustration({super.key, this.size = 280});

  @override
  State<Onboard2Illustration> createState() => _Onboard2IllustrationState();
}

class _Onboard2IllustrationState extends State<Onboard2Illustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, _) {
        final t = _animController.value;
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: CustomPaint(painter: _Onboard2Painter(steamProgress: t)),
        );
      },
    );
  }
}

class _Onboard2Painter extends CustomPainter {
  final double steamProgress;

  _Onboard2Painter({required this.steamProgress});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final scale = size.width / 260.0;
    canvas.scale(scale, scale);

    // -------------------------------------------------------------
    // 1. SOFT WARM BACKDROP
    // -------------------------------------------------------------
    final bgPaint = Paint()
      ..color = const Color(0xFFFFFBEB)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(130, 130), 96, bgPaint);

    final bgInnerPaint = Paint()
      ..color = const Color(0xFFFEF3C7)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(130, 132), 76, bgInnerPaint);

    // -------------------------------------------------------------
    // 2. CHEF HAT (Puffy Red / Coral Hat)
    // -------------------------------------------------------------
    final hatRed = const Color(0xFFEF4444);
    final hatPaint = Paint()..color = hatRed;

    // Hat base band
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(112, 60, 36, 16),
        const Radius.circular(4),
      ),
      hatPaint,
    );
    // Puffy hat clouds
    canvas.drawCircle(const Offset(118, 48), 16, hatPaint);
    canvas.drawCircle(const Offset(130, 38), 18, hatPaint);
    canvas.drawCircle(const Offset(142, 48), 16, hatPaint);

    // -------------------------------------------------------------
    // 3. CHEF HEAD & BODY
    // -------------------------------------------------------------
    // Black Hair
    canvas.drawCircle(
      const Offset(130, 80),
      18,
      Paint()..color = const Color(0xFF1E293B),
    );
    // Face
    canvas.drawCircle(
      const Offset(130, 83),
      15,
      Paint()..color = const Color(0xFFFDBA74),
    );

    // Yellow Chef Shirt / Torso
    final shirtPath = Path()
      ..moveTo(96, 110)
      ..lineTo(164, 110)
      ..lineTo(185, 185)
      ..lineTo(75, 185)
      ..close();
    canvas.drawPath(shirtPath, Paint()..color = const Color(0xFFFBBF24));

    // Red Apron (Bib & Body)
    final apronPath = Path()
      ..moveTo(108, 118)
      ..lineTo(152, 118)
      ..lineTo(168, 185)
      ..lineTo(92, 185)
      ..close();
    canvas.drawPath(apronPath, Paint()..color = const Color(0xFFDC2626));

    // Apron Straps over shoulders
    final strapPaint = Paint()
      ..color = const Color(0xFFB91C1C)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(114, 108), const Offset(116, 122), strapPaint);
    canvas.drawLine(const Offset(146, 108), const Offset(144, 122), strapPaint);

    // Arms
    final armPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    // Left arm holding spoon
    canvas.drawLine(const Offset(85, 140), const Offset(112, 155), armPaint);
    // Right arm resting near counter
    canvas.drawLine(const Offset(175, 140), const Offset(155, 170), armPaint);

    // Wooden spoon
    final spoonPaint = Paint()
      ..color = const Color(0xFFD97706)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(112, 155), const Offset(116, 175), spoonPaint);

    // -------------------------------------------------------------
    // 4. STOVE COUNTER & COOKING APPLIANCES
    // -------------------------------------------------------------
    // Counter shelf
    final counterPaint = Paint()..color = const Color(0xFFF59E0B);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(45, 188, 170, 7),
        const Radius.circular(3.5),
      ),
      counterPaint,
    );

    // Gas burner rings underneath
    final burnerPaint = Paint()..color = const Color(0xFF334155);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(82, 182, 34, 6),
        const Radius.circular(2),
      ),
      burnerPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(138, 182, 34, 6),
        const Radius.circular(2),
      ),
      burnerPaint,
    );

    // Cooking Pot (Dark Navy Blue with Silver Rim)
    final potPath = Path()
      ..moveTo(82, 162)
      ..lineTo(116, 162)
      ..lineTo(112, 182)
      ..lineTo(86, 182)
      ..close();
    canvas.drawPath(potPath, Paint()..color = const Color(0xFF1E293B));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(80, 158, 38, 4.5),
        const Radius.circular(2),
      ),
      Paint()..color = const Color(0xFF94A3B8),
    );

    // Sizzling Pan / Skillet
    final panPath = Path()
      ..moveTo(136, 172)
      ..lineTo(172, 172)
      ..lineTo(168, 182)
      ..lineTo(140, 182)
      ..close();
    canvas.drawPath(panPath, Paint()..color = const Color(0xFF64748B));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(134, 169, 42, 3.5),
        const Radius.circular(1.5),
      ),
      Paint()..color = const Color(0xFFCBD5E1),
    );

    // Sauce / Olive Oil Bottle on right counter
    final bottlePath = Path()
      ..moveTo(194, 162)
      ..lineTo(198, 162)
      ..lineTo(199, 188)
      ..lineTo(193, 188)
      ..close();
    canvas.drawPath(bottlePath, Paint()..color = const Color(0xFF0F172A));
    // Blue label
    canvas.drawRect(
      const Rect.fromLTWH(193.5, 172, 5, 10),
      Paint()..color = const Color(0xFF2563EB),
    );

    // -------------------------------------------------------------
    // 5. ANIMATED RISING STEAM WAVES
    // -------------------------------------------------------------
    final steamShift = (steamProgress * 20.0);
    final steamPaint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.85)
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Steam curl 1 over pot
    final s1 = Path()
      ..moveTo(93, 154 - steamShift)
      ..quadraticBezierTo(90, 146 - steamShift, 95, 138 - steamShift);
    canvas.drawPath(s1, steamPaint);

    // Steam curl 2 over pot
    final s2 = Path()
      ..moveTo(105, 152 - steamShift)
      ..quadraticBezierTo(108, 144 - steamShift, 103, 136 - steamShift);
    canvas.drawPath(s2, steamPaint);

    // Steam curl 3 over pan
    final s3 = Path()
      ..moveTo(152, 164 - steamShift)
      ..quadraticBezierTo(155, 156 - steamShift, 150, 148 - steamShift);
    canvas.drawPath(s3, steamPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _Onboard2Painter oldDelegate) =>
      oldDelegate.steamProgress != steamProgress;
}
