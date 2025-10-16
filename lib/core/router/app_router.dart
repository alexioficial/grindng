import 'package:flutter/material.dart';
import 'package:grindng/features/auth/presentation/login_screen.dart';
import 'package:grindng/features/home/presentation/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
}

Route<dynamic>? onGenerateAppRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Route not found')),
        ),
      );
  }
}
