import 'package:flutter/widgets.dart';
import 'package:grindng/features/auth/application/auth_controller.dart';

class AuthScope extends InheritedNotifier<AuthController> {
  const AuthScope({super.key, required AuthController controller, required Widget child})
      : super(notifier: controller, child: child);

  static AuthController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AuthScope>();
    assert(scope != null, 'AuthScope not found');
    return scope!.notifier!;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<AuthController> oldWidget) {
    return oldWidget.notifier != notifier;
  }
}
