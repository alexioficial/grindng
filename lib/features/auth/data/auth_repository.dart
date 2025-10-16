class AuthRepository {
  Future<String> signIn({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Credenciales inválidas');
    }
    return 'token_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
