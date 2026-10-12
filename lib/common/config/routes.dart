import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_app/features/auth/bloc/auth_bloc.dart';
import 'package:practise_app/features/home/ui/dashboard_screen.dart';
import 'package:practise_app/features/onboard/ui/onboard_screen.dart';
import 'package:practise_app/features/splash/ui/splash_screen.dart';
import 'package:practise_app/features/auth/ui/login_screen.dart';
import 'package:practise_app/features/auth/ui/profile_edit_screen.dart';

/// Centralized Application Routing Configuration.
class AppRoutes {
  static const String splash = '/';
  static const String onboard = '/onboard';
  static const String dashboard = '/dashboard';
  static const String login = '/login';
  static const String profileEdit = '/profile-edit';
  static const String authCallback = '/link';

  /// Generates routes with smooth page transitions
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routePath = Uri.tryParse(settings.name ?? '')?.path;
    if (routePath == authCallback) {
      return _buildPageRoute(const _AuthCallbackScreen(), settings);
    }

    switch (settings.name) {
      case splash:
        return _buildPageRoute(const SplashScreen(), settings);

      case onboard:
        return _buildPageRoute(const OnboardScreen(), settings);

      case dashboard:
        return _buildPageRoute(const DashboardScreen(), settings);

      case login:
        return _buildPageRoute(const LoginScreen(), settings);

      case profileEdit:
        return _buildPageRoute(const ProfileEditScreen(), settings);

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
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
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
    );
  }
}

class _AuthCallbackScreen extends StatelessWidget {
  const _AuthCallbackScreen();

  void _goToDashboard(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.dashboard, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          _goToDashboard(context);
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
