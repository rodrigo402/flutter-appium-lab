import 'package:appium_flutter_demo/app/router/app_router.dart';
import 'package:appium_flutter_demo/app/router/app_routes.dart';
import 'package:appium_flutter_demo/app/theme/app_theme.dart';
import 'package:appium_flutter_demo/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AppiumFlutterDemoApp extends StatelessWidget {
  const AppiumFlutterDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.light,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
