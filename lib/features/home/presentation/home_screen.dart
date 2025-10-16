import 'package:flutter/material.dart';
import 'package:grindng/core/router/app_router.dart';
import 'package:grindng/features/auth/shared/auth_scope.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.signOut();
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text(controller.state.email ?? ''),
      ),
    );
  }
}
