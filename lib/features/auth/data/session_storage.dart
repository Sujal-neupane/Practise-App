import 'package:shared_preferences/shared_preferences.dart';

class SessionStorage {
  static const _onboardingCompletedKey = 'onboarding_completed';

  static Future<bool> hasCompletedOnboarding() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_onboardingCompletedKey) ?? false;
  }

  static Future<void> markOnboardingCompleted() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_onboardingCompletedKey, true);
  }
}
