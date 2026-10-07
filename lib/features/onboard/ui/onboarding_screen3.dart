import 'package:flutter/material.dart';
import 'package:practise_app/common/theme/app_colors.dart';
import 'package:practise_app/features/onboard/ui/widgets/onboard3_illustration.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),

          // Creative Vector Illustration with Courier & Retro Scooter
          const Onboard3Illustration(size: 260),

          const Spacer(flex: 1),

          // Title
          const Text(
            'Free delivery offers',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),

          const SizedBox(height: 14),

          // Subtitle
          const Text(
            'Get all your loved foods in one once place,\nyou just place the orer we do the rest',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.55,
              fontWeight: FontWeight.w400,
            ),
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

