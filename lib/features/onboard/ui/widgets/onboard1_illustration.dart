import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:practise_app/common/theme/app_colors.dart';

/// Creative vector illustration for Onboarding 1:
/// Customer relaxing with tablet, surrounded by floating food items (burger, fries, pizza, drink, noodles)
/// with subtle floating micro-animation.
class Onboard1Illustration extends StatefulWidget {
  final double size;

  const Onboard1Illustration({
    super.key,
    this.size = 280,
  });

  @override
  State<Onboard1Illustration> createState() => _Onboard1IllustrationState();
}

class _Onboard1IllustrationState extends State<Onboard1Illustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
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
            painter: _Onboard1Painter(progress: t),
          ),
        );
      },
    );
  }
}

class _Onboard1Painter extends CustomPainter {
  final double progress;

  _Onboard1Painter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    final scale = size.width / 260.0;
    canvas.scale(scale, scale);

    // Floating bobbing offsets
    final float1 = math.sin(progress * math.pi * 2) * 4.5;
    final float2 = math.cos(progress * math.pi * 2) * 5.0;
    final float3 = math.sin((progress + 0.3) * math.pi * 2) * 4.0;

    // -------------------------------------------------------------
    // 1. SOFT WARM CIRCULAR BACKDROP
    // -------------------------------------------------------------
    final bgPaint = Paint()
      ..color = const Color(0xFFFFF5EB)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(130, 140), 95, bgPaint);

    final bgInnerPaint = Paint()
      ..color = const Color(0xFFFFECE0)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(130, 142), 75, bgInnerPaint);

    // -------------------------------------------------------------
    // 2. FLOATING CONFETTI PARTICLES
    // -------------------------------------------------------------
    final orangeDot = Paint()..color = AppColors.primary;
    final yellowDot = Paint()..color = const Color(0xFFFBBF24);

    canvas.drawCircle(Offset(45, 60 + float1), 3.5, orangeDot);
    canvas.drawCircle(Offset(215, 65 + float2), 3.5, orangeDot);
    canvas.drawCircle(Offset(180, 25 + float3), 4.0, orangeDot);

    // Diamond confetti
    final diamondPath = Path()
      ..moveTo(125, 20 + float2)
      ..lineTo(128.5, 24 + float2)
      ..lineTo(125, 28 + float2)
      ..lineTo(121.5, 24 + float2)
      ..close();
    canvas.drawPath(diamondPath, yellowDot);

    final diamond2 = Path()
      ..moveTo(95, 62 + float1)
      ..lineTo(98, 65 + float1)
      ..lineTo(95, 68 + float1)
      ..lineTo(92, 65 + float1)
      ..close();
    canvas.drawPath(diamond2, yellowDot);

    // -------------------------------------------------------------
    // 3. FLOATING FOOD ITEMS
    // -------------------------------------------------------------

    // A. DRINK CUP WITH STRAW (Top Left)
    canvas.save();
    canvas.translate(88, 48 + float1);
    canvas.rotate(-0.12);
    // Cup body
    final cupPath = Path()
      ..moveTo(-12, 18)
      ..lineTo(12, 18)
      ..lineTo(9, 44)
      ..lineTo(-9, 44)
      ..close();
    canvas.drawPath(cupPath, Paint()..color = const Color(0xFFFED7AA));
    // Red sleeve band
    final bandPath = Path()
      ..moveTo(-10.5, 26)
      ..lineTo(10.5, 26)
      ..lineTo(9.8, 36)
      ..lineTo(-9.8, 36)
      ..close();
    canvas.drawPath(bandPath, Paint()..color = const Color(0xFFEF4444));
    // White lid
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-14, 13, 28, 6), const Radius.circular(3)),
      Paint()..color = const Color(0xFF7C2D12),
    );
    // Straw
    final strawPaint = Paint()
      ..color = const Color(0xFFF97316)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, 13), const Offset(6, 2), strawPaint);
    canvas.restore();

    // B. BOWL OF SOUP / NOODLES (Top Center)
    canvas.save();
    canvas.translate(155, 38 + float2);
    // White Bowl
    final bowlPath = Path()
      ..moveTo(-18, 0)
      ..lineTo(18, 0)
      ..quadraticBezierTo(14, 18, 0, 18)
      ..quadraticBezierTo(-14, 18, -18, 0)
      ..close();
    canvas.drawPath(bowlPath, Paint()..color = const Color(0xFFF1F5F9));
    // Red soup content
    final soupPath = Path()
      ..addOval(const Rect.fromLTWH(-17, -4, 34, 10));
    canvas.drawPath(soupPath, Paint()..color = const Color(0xFFDC2626));
    // Veggie garnishes
    canvas.drawCircle(const Offset(-4, 0), 2.5, Paint()..color = const Color(0xFF10B981));
    canvas.drawCircle(const Offset(5, 1), 2.5, Paint()..color = const Color(0xFFF59E0B));
    canvas.restore();

    // C. BURGER (Top Right)
    canvas.save();
    canvas.translate(195, 68 + float3);
    canvas.rotate(0.14);
    // Top Bun
    final bunTop = Path()
      ..addArc(const Rect.fromLTWH(-18, -8, 36, 18), math.pi, math.pi);
    canvas.drawPath(bunTop, Paint()..color = const Color(0xFFFDBA74));
    // Lettuce & Cheese
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-18, 1, 36, 4), const Radius.circular(2)),
      Paint()..color = const Color(0xFF84CC16),
    );
    // Patty
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-17, 5, 34, 4), const Radius.circular(2)),
      Paint()..color = const Color(0xFF78350F),
    );
    // Bottom Bun
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-17, 9, 34, 5), const Radius.circular(3)),
      Paint()..color = const Color(0xFFFDBA74),
    );
    canvas.restore();

    // D. FRENCH FRIES (Left)
    canvas.save();
    canvas.translate(56, 85 + float2);
    canvas.rotate(-0.18);
    // Red Fries Carton
    final friesBox = Path()
      ..moveTo(-13, 0)
      ..lineTo(13, 0)
      ..lineTo(10, 24)
      ..lineTo(-10, 24)
      ..close();
    canvas.drawPath(friesBox, Paint()..color = const Color(0xFFEF4444));
    // Yellow Fries sticks
    final fryPaint = Paint()
      ..color = const Color(0xFFFBBF24)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(-8, 3), const Offset(-10, -10), fryPaint);
    canvas.drawLine(const Offset(-3, 3), const Offset(-4, -14), fryPaint);
    canvas.drawLine(const Offset(2, 3), const Offset(2, -12), fryPaint);
    canvas.drawLine(const Offset(7, 3), const Offset(8, -8), fryPaint);
    canvas.restore();

    // E. PIZZA SLICE (Right)
    canvas.save();
    canvas.translate(205, 108 + float1);
    canvas.rotate(0.24);
    final pizzaPath = Path()
      ..moveTo(0, -15)
      ..lineTo(15, 15)
      ..lineTo(-15, 15)
      ..close();
    canvas.drawPath(pizzaPath, Paint()..color = const Color(0xFFFBBF24));
    // Crust
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(-16, 13, 32, 5), const Radius.circular(2.5)),
      Paint()..color = const Color(0xFFD97706),
    );
    // Pepperoni circles
    final pepPaint = Paint()..color = const Color(0xFFDC2626);
    canvas.drawCircle(const Offset(0, 0), 2.8, pepPaint);
    canvas.drawCircle(const Offset(-4, 9), 2.5, pepPaint);
    canvas.drawCircle(const Offset(5, 7), 2.5, pepPaint);
    canvas.restore();

    // -------------------------------------------------------------
    // 4. PERSON SITTING WITH TABLET (Center Character)
    // -------------------------------------------------------------
    // Head & Hair
    canvas.drawCircle(const Offset(125, 96), 13, Paint()..color = const Color(0xFFFDBA74)); // face
    final hairPath = Path()
      ..addArc(const Rect.fromLTWH(112, 83, 26, 20), math.pi, math.pi);
    canvas.drawPath(hairPath, Paint()..color = const Color(0xFF1E293B)); // hair

    // Yellow Sweatshirt Torso
    final torsoPath = Path()
      ..moveTo(108, 114)
      ..lineTo(142, 114)
      ..lineTo(146, 162)
      ..lineTo(102, 162)
      ..close();
    canvas.drawPath(torsoPath, Paint()..color = const Color(0xFFF59E0B));

    // Arms holding tablet
    final armPath = Path()
      ..moveTo(136, 122)
      ..lineTo(162, 142)
      ..lineTo(152, 148)
      ..lineTo(130, 130)
      ..close();
    canvas.drawPath(armPath, Paint()..color = const Color(0xFFF59E0B));

    // Hands
    canvas.drawCircle(const Offset(158, 144), 5, Paint()..color = const Color(0xFFFDBA74));

    // Tablet
    final tabletPath = Path()
      ..moveTo(156, 130)
      ..lineTo(176, 144)
      ..lineTo(165, 164)
      ..lineTo(145, 150)
      ..close();
    canvas.drawPath(tabletPath, Paint()..color = const Color(0xFF334155));

    // Red Pants / Crossed Legs
    final legLeft = Path()
      ..moveTo(102, 160)
      ..quadraticBezierTo(90, 185, 125, 192)
      ..quadraticBezierTo(145, 185, 140, 160)
      ..close();
    canvas.drawPath(legLeft, Paint()..color = const Color(0xFFEF4444));

    final legRight = Path()
      ..moveTo(125, 162)
      ..lineTo(185, 182)
      ..lineTo(175, 194)
      ..lineTo(115, 175)
      ..close();
    canvas.drawPath(legRight, Paint()..color = const Color(0xFFDC2626));

    // Dark Shoes
    canvas.drawRRect(
      RRect.fromRectAndRadius(const Rect.fromLTWH(180, 180, 24, 11), const Radius.circular(5)),
      Paint()..color = const Color(0xFF1E293B),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _Onboard1Painter oldDelegate) =>
      oldDelegate.progress != progress;
}

