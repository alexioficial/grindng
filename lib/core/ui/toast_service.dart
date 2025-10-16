import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> toastMessengerKey = GlobalKey<ScaffoldMessengerState>();

class ToastService {
  static void showTop(String message) {
    final messenger = toastMessengerKey.currentState;
    if (messenger == null) return;

    messenger.hideCurrentMaterialBanner();
    messenger.showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.red.shade600,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => messenger.hideCurrentMaterialBanner(),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    Future.delayed(const Duration(seconds: 5), () {
      messenger.hideCurrentMaterialBanner();
    });
  }
}
