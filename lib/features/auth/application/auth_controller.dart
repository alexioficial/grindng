import 'package:flutter/foundation.dart';
import 'package:grindng/features/auth/data/auth_repository.dart';
import 'package:grindng/features/auth/domain/auth_state.dart';
import 'package:grindng/core/auth/token_storage.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository _repo;
  AuthState _state = AuthState.signedOut();

  AuthController(this._repo);

  AuthState get state => _state;

  Future<void> hydrate() async {
    final token = await TokenStorage.read();
    if (token != null && token.isNotEmpty) {
      _state = AuthState.signedIn(token: token);
      notifyListeners();
    }
  }

  Future<void> signIn(String email, String password) async {
    final token = await _repo.signIn(email: email, password: password);
    await TokenStorage.save(token);
    _state = AuthState.signedIn(token: token, email: email);
    notifyListeners();
  }

  Future<void> signOut() async {
    await TokenStorage.clear();
    await _repo.signOut();
    _state = AuthState.signedOut();
    notifyListeners();
  }
}
