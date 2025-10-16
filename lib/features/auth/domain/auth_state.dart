class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? email;

  const AuthState({required this.isAuthenticated, this.token, this.email});

  factory AuthState.signedOut() => const AuthState(isAuthenticated: false);

  factory AuthState.signedIn({required String token, String? email}) =>
      AuthState(isAuthenticated: true, token: token, email: email);
}
