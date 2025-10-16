import 'package:flutter/material.dart';
import 'package:grindng/core/router/app_router.dart';
import 'package:grindng/core/ui/toast_service.dart';
import 'package:grindng/features/auth/application/auth_controller.dart';
import 'package:grindng/features/auth/data/auth_repository.dart';
import 'package:grindng/features/auth/shared/auth_scope.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late final AuthController _authController;

  @override
  void initState() {
    super.initState();
    _authController = AuthController(AuthRepository());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _authController.hydrate();
      if (!mounted) return;
      if (_authController.state.isAuthenticated) {
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScope(
      controller: _authController,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grindng',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        scaffoldMessengerKey: toastMessengerKey,
        onGenerateRoute: onGenerateAppRoute,
        initialRoute: _authController.state.isAuthenticated ? AppRoutes.home : AppRoutes.login,
      ),
    );
  }
}
