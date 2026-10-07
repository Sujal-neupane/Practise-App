import 'package:flutter/material.dart';
import 'package:practise_app/common/theme/app_colors.dart';
import 'package:practise_app/common/widgets/food_logo.dart';
import 'package:practise_app/features/splash/ui/widgets/splash_rays_painter.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback? onAnimationComplete;

  const SplashScreen({super.key, this.onAnimationComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // 1. Overall logo entrance (fade & scale)
  late final Animation<double> _logoEntranceScale;
  late final Animation<double> _logoEntranceOpacity;

  // 2. Cloche lifting up animation & 2 o's bouncy reveal
  late final Animation<double> _clocheLiftAnimation;
  late final Animation<double> _oRevealAnimation;

  // 3. Screen 2 decorative fan rays expansion
  late final Animation<double> _raysProgressAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );

    // Step 1: Logo fades & pops into view (0 to ~800ms)
    _logoEntranceOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.28, curve: Curves.easeIn),
      ),
    );

    _logoEntranceScale = Tween<double>(begin: 0.70, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.32, curve: Curves.easeOutBack),
      ),
    );

    // Step 2: Cloche lifts up with spring bounce (~900ms to ~1800ms)
    _clocheLiftAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.32, 0.64, curve: Curves.easeOutBack),
      ),
    );

    // The two orange "o"s bounce into view as lid lifts
    _oRevealAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.68, curve: Curves.elasticOut),
      ),
    );

    // Step 3: Decorative rays emerge for Screen 2 transition (~1600ms to ~2600ms)
    _raysProgressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.58, 0.92, curve: Curves.easeOutCubic),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _replay() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // -------------------------------------------------------------
          // 1. DECORATIVE RAYS LAYER (Screen 2 sunburst fan rays)
          // -------------------------------------------------------------
          AnimatedBuilder(
            animation: _raysProgressAnimation,
            builder: (context, _) {
              return CustomPaint(
                size: screenSize,
                painter: SplashRaysPainter(
                  progress: _raysProgressAnimation.value,
                  orangeColor: AppColors.splashRaysOrange,
                  greyColor: AppColors.splashRaysGrey,
                ),
              );
            },
          ),

          // -------------------------------------------------------------
          // 2. CENTER "Food" LOGO WITH ANIMATED CLOCHE & 2 "o"s
          // -------------------------------------------------------------
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Opacity(
                  opacity: _logoEntranceOpacity.value,
                  child: Transform.scale(
                    scale: _logoEntranceScale.value,
                    child: FoodLogo(
                      fontSize: 56,
                      clocheLift: _clocheLiftAnimation.value,
                      oReveal: _oRevealAnimation.value,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
