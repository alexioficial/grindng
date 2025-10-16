import 'package:grindng/core/network/api_client.dart';

class AuthRepository {
  final ApiClient _api;

  AuthRepository({ApiClient? api}) : _api = api ?? ApiClient();

  Future<String> signIn({required String email, required String password}) async {
    final data = await _api.post(
      '/login',
      body: {
        'email': email,
        'password': password,
      },
    );
    final token = (data is Map && data['token'] is String) ? data['token'] as String : null;
    if (token == null) {
      throw ApiError(message: 'Token no encontrado en la respuesta', data: data);
    }
    return token;
  }

  Future<void> signOut() async {
    // If server needs logout call, use _api.post('/auth/logout') here.
  }
}
