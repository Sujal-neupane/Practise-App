import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise_app/common/config/routes.dart';
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
  Timer? _timer;
  bool _hasNavigated = false;

  // 1. Logo entrance (fade & subtle scale)
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;

  // 2. Cloche lifting up & tilting
  late final Animation<double> _clocheLift;
  late final Animation<double> _oPop;

  // 3. Circular fan rays expansion in corners
  late final Animation<double> _raysProgress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    // Phase 1: Logo fades & appears in center (0 to 750ms)
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.28, curve: Curves.easeIn),
      ),
    );
    _logoScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.32, curve: Curves.easeOutCubic),
      ),
    );

    // Phase 2: Cloche lifts up & tilts smoothly (800ms to 1600ms)
    _clocheLift = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.32, 0.65, curve: Curves.easeOutBack),
      ),
    );
    _oPop = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.34, 0.68, curve: Curves.easeOutBack),
      ),
    );

    // Phase 3: Screen 2 corner fan rays expand (1500ms to 2400ms)
    _raysProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.58, 0.92, curve: Curves.easeOutCubic),
      ),
    );

    // UX Law: Predictability & Feedback
    // Automatically transition to Onboarding after 5 seconds
    _timer = Timer(const Duration(seconds: 5), _navigateToOnboard);

    _controller.forward();
  }

  void _navigateToOnboard() {
    if (_hasNavigated || !mounted) return;
    _hasNavigated = true;
    _timer?.cancel();

    if (widget.onAnimationComplete != null) {
      widget.onAnimationComplete!();
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.onboard);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        // UX Law: User Control & Freedom (allow tapping to skip splash)
        body: GestureDetector(
          onTap: _navigateToOnboard,
          behavior: HitTestBehavior.opaque,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. CORNER FAN RAYS (Top-Left Grey, Bottom-Right Orange)
              AnimatedBuilder(
                animation: _raysProgress,
                builder: (context, _) {
                  return CustomPaint(
                    size: screenSize,
                    painter: SplashRaysPainter(
                      progress: _raysProgress.value,
                      orangeColor: AppColors.splashRaysOrange,
                      greyColor: AppColors.splashRaysGrey,
                    ),
                  );
                },
              ),

              // 2. FOOD LOGO WITH ANIMATED CLOCHE LIFT
              Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Opacity(
                      opacity: _logoOpacity.value,
                      child: Transform.scale(
                        scale: _logoScale.value,
                        child: FoodLogo(
                          width: 195,
                          clocheLift: _clocheLift.value,
                          oPop: _oPop.value,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 3. REPLAY BUTTON FOR DEV PREVIEW
              Positioned(
                bottom: 36,
                right: 24,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final isDone = _controller.isCompleted;
                    return AnimatedOpacity(
                      opacity: isDone ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      child: IconButton.filledTonal(
                        onPressed: isDone ? _replay : null,
                        tooltip: 'Replay animation',
                        icon: const Icon(Icons.replay_rounded, size: 22),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          foregroundColor: AppColors.primary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
