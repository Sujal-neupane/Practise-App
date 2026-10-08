import 'package:flutter/material.dart';
import 'package:practise_app/features/home/ui/dashboard_screen.dart';
import 'package:practise_app/features/onboard/ui/onboard_screen.dart';
import 'package:practise_app/features/splash/ui/splash_screen.dart';

/// Centralized Application Routing Configuration.
class AppRoutes {
  static const String splash = '/';
  static const String onboard = '/onboard';
  static const String dashboard = '/dashboard';

  /// Generates routes with smooth page transitions
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildPageRoute(
          const SplashScreen(),
          settings,
        );

      case onboard:
        return _buildPageRoute(
          const OnboardScreen(),
          settings,
        );

      case dashboard:
        return _buildPageRoute(
          const DashboardScreen(),
          settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  /// Builds a smooth Fade/Slide page transition
  static PageRouteBuilder<dynamic> _buildPageRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: child,
        );
      },
    );
  }
}

