import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:practise_app/common/theme/app_colors.dart';

/// Creative vector illustration for Onboarding 3:
/// Delivery courier holding a package standing next to a retro delivery scooter with confetti.
class Onboard3Illustration extends StatefulWidget {
  final double size;

  const Onboard3Illustration({
    super.key,
    this.size = 280,
  });

  @override
  State<Onboard3Illustration> createState() => _Onboard3IllustrationState();
}

class _Onboard3IllustrationState extends State<Onboard3Illustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
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
          child: CustomPaint(
            painter: _Onboard3Painter(progress: t),
          ),
        );
      },
    );
  }
}

class _Onboard3Painter extends CustomPainter {
  final double progress;

  _Onboard3Painter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final scale = size.width / 260.0;
    canvas.scale(scale, scale);

    final float1 = math.sin(progress * math.pi * 2) * 3.5;
    final float2 = math.cos(progress * math.pi * 2) * 4.0;

    // -------------------------------------------------------------
    // 1. GROUND SHADOW & BACKDROP
    // -------------------------------------------------------------
    final groundPaint = Paint()..color = const Color(0xFFF1F5F9);
    canvas.drawOval(const Rect.fromLTWH(30, 192, 200, 18), groundPaint);

    // -------------------------------------------------------------
    // 2. FLOATING CONFETTI PARTICLES
    // -------------------------------------------------------------
    final greenDot = Paint()..color = const Color(0xFF10B981);
    final orangeDot = Paint()..color = AppColors.primary;
    final yellowDot = Paint()..color = const Color(0xFFFBBF24);

    canvas.drawCircle(Offset(60, 45 + float1), 3.5, greenDot);
    canvas.drawCircle(Offset(180, 55 + float2), 3.5, greenDot);
    canvas.drawCircle(Offset(220, 85 + float1), 3.0, orangeDot);
    canvas.drawCircle(Offset(175, 120 + float2), 3.5, greenDot);

    // Diamond confetti
    final diamond1 = Path()
      ..moveTo(85, 55 + float2)
      ..lineTo(88, 58 + float2)
      ..lineTo(85, 61 + float2)
      ..lineTo(82, 58 + float2)
      ..close();
    canvas.drawPath(diamond1, yellowDot);

    final diamond2 = Path()
      ..moveTo(200, 125 + float1)
      ..lineTo(203, 128 + float1)
      ..lineTo(200, 131 + float1)
      ..lineTo(197, 128 + float1)
      ..close();
    canvas.drawPath(diamond2, yellowDot);

    // -------------------------------------------------------------
    // 3. RETRO DELIVERY SCOOTER / MOPED
    // -------------------------------------------------------------
    // Rear Wheel
    canvas.drawCircle(const Offset(180, 182), 16, Paint()..color = const Color(0xFF1E293B));
    canvas.drawCircle(const Offset(180, 182), 9, Paint()..color = const Color(0xFFFFEDD5));

    // Front Wheel
    canvas.drawCircle(const Offset(70, 182), 16, Paint()..color = const Color(0xFF1E293B));
    canvas.drawCircle(const Offset(70, 182), 9, Paint()..color = const Color(0xFFFFEDD5));

    // Scooter Body Shell (Orange / Coral)
    final scooterBody = Path()
      ..moveTo(80, 175)
      ..lineTo(190, 175)
      ..quadraticBezierTo(200, 140, 180, 130)
      ..lineTo(140, 130)
      ..quadraticBezierTo(115, 130, 95, 150)
      ..lineTo(75, 155)
      ..close();
    canvas.drawPath(scooterBody, Paint()..color = const Color(0xFFFB923C));

    // Scooter Lower Fairing
    final fairingPath = Path()
      ..moveTo(80, 165)
      ..lineTo(185, 165)
      ..lineTo(170, 182)
      ..lineTo(75, 182)
      ..close();
    canvas.drawPath(fairingPath, Paint()..color = AppColors.primary);

    // Steering Column & Handle
    final steerPath = Path()
      ..moveTo(92, 145)
      ..lineTo(92, 95)
      ..lineTo(105, 95)
      ..lineTo(105, 145)
      ..close();
    canvas.drawPath(steerPath, Paint()..color = const Color(0xFFFED7AA));

    // Headlight Box
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(80, 112, 18, 18), const Radius.circular(5)),
      Paint()..color = const Color(0xFF1E293B),
    );
    canvas.drawCircle(const Offset(80, 121), 6, Paint()..color = const Color(0xFFFEF08A)); // light beam

    // Scooter Seat Cushion (Tan / Leather)
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(90, 90, 30, 12), const Radius.circular(6)),
      Paint()..color = const Color(0xFFEA580C),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(145, 124, 60, 16), const Radius.circular(8)),
      Paint()..color = const Color(0xFFFED7AA),
    );

    // -------------------------------------------------------------
    // 4. DELIVERY COURIER (Standing in Center/Foreground)
    // -------------------------------------------------------------
    // Dark Hair
    canvas.drawCircle(const Offset(135, 42), 12, Paint()..color = const Color(0xFF1E293B));
    // Face
    canvas.drawCircle(const Offset(135, 45), 10, Paint()..color = const Color(0xFFFDBA74));

    // Yellow Sweatshirt Torso
    final torsoPath = Path()
      ..moveTo(122, 60)
      ..lineTo(152, 60)
      ..lineTo(154, 115)
      ..lineTo(120, 115)
      ..close();
    canvas.drawPath(torsoPath, Paint()..color = const Color(0xFFFBBF24));

    // Red Trousers / Legs
    // Left leg
    final leftLeg = Path()
      ..moveTo(122, 115)
      ..lineTo(136, 115)
      ..lineTo(134, 192)
      ..lineTo(122, 192)
      ..close();
    canvas.drawPath(leftLeg, Paint()..color = const Color(0xFFDC2626));

    // Right leg
    final rightLeg = Path()
      ..moveTo(138, 115)
      ..lineTo(152, 115)
      ..lineTo(148, 192)
      ..lineTo(136, 192)
      ..close();
    canvas.drawPath(rightLeg, Paint()..color = const Color(0xFFEF4444));

    // Green Shoes
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(120, 190, 16, 7), const Radius.circular(3)),
      Paint()..color = const Color(0xFF047857),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(135, 190, 16, 7), const Radius.circular(3)),
      Paint()..color = const Color(0xFF047857),
    );

    // Arms Holding Cardboard Box
    final armPath = Path()
      ..moveTo(136, 68)
      ..lineTo(168, 88)
      ..lineTo(158, 96)
      ..lineTo(130, 78)
      ..close();
    canvas.drawPath(armPath, Paint()..color = const Color(0xFFF59E0B));

    // -------------------------------------------------------------
    // 5. CARDBOARD DELIVERY PACKAGE BOX
    // -------------------------------------------------------------
    canvas.save();
    canvas.translate(0, float1 * 0.4);
    final boxRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(158, 72, 44, 34),
      const Radius.circular(3.5),
    );
    canvas.drawRRect(boxRect, Paint()..color = const Color(0xFFFED7AA));

    // Packaging tape strap
    canvas.drawRect(
      const Rect.fromLTWH(180, 72, 6, 34),
      Paint()..color = const Color(0xFF1E293B),
    );
    canvas.restore();

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _Onboard3Painter oldDelegate) =>
      oldDelegate.progress != progress;
}

