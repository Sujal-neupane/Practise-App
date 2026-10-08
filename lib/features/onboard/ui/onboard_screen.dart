import 'package:flutter/material.dart';
import 'package:practise_app/common/config/routes.dart';
import 'package:practise_app/common/theme/app_colors.dart';
import 'package:practise_app/features/auth/data/session_storage.dart';
import 'package:practise_app/features/onboard/ui/onboarding_screen1.dart';
import 'package:practise_app/features/onboard/ui/onboarding_screen2.dart';
import 'package:practise_app/features/onboard/ui/onboarding_screen3.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = const [
    OnboardingScreen1(),
    OnboardingScreen2(),
    OnboardingScreen3(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onNext() async {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // Completed onboarding -> Navigate to Dashboard
      await SessionStorage.markOnboardingCompleted();
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
    }
  }

  void _onSkip() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Swipeable Onboarding Screens
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _pages,
              ),
            ),

            // -------------------------------------------------------------
            // BOTTOM CONTROLS (Indicator Dots + Action Buttons)
            // -------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Dots Indicator (matching design with 4 dots)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      final isActive = _currentPage == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4.5),
                        width: isActive ? 10 : 7,
                        height: isActive ? 10 : 7,
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.indicatorActive
                              : AppColors.indicatorInactive,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 32),

                  // Solid Orange Action Button (NEXT / GET STARTED)
                  ElevatedButton(
                    onPressed: _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      isLastPage ? 'GET STARTED' : 'NEXT',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Skip Button (Hidden on the final slide)
                  SizedBox(
                    height: 40,
                    child: isLastPage
                        ? const SizedBox.shrink()
                        : TextButton(
                            onPressed: _onSkip,
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
