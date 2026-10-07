import 'package:flutter/material.dart';
import 'package:practise_app/common/constants/app_constants.dart';
import 'package:practise_app/common/theme/app_theme.dart';
import 'package:practise_app/features/splash/ui/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
