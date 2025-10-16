import 'package:flutter/material.dart';
import 'package:grindng/app/app_root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppRoot();
  }
}
