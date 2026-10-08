import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise_app/common/config/routes.dart';
import 'package:practise_app/common/constants/app_constants.dart';
import 'package:practise_app/common/theme/app_theme.dart';
import 'package:practise_app/features/auth/bloc/auth_bloc.dart';
import 'package:practise_app/features/auth/data/auth_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
          AuthBloc(AuthRepository())
            ..add(AuthSubscriptionRequested()),
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
