import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grindng/core/config/app_config.dart';
import 'package:grindng/core/ui/toast_service.dart';
import 'package:grindng/core/auth/token_storage.dart';

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, String>> _authHeaders() async {
    final token = await TokenStorage.read();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Uri _uri(String path, [Map<String, dynamic>? query]) {
    return Uri.parse(AppConfig.baseUrl).replace(
      path: path.startsWith('/') ? path : '/$path',
      queryParameters: query?.map((k, v) => MapEntry(k, '$v')),
    );
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    final res = await _client.get(_uri(path, query), headers: await _authHeaders());
    return _handle(res);
  }

  Future<dynamic> post(String path, {Object? body, Map<String, dynamic>? query}) async {
    final res = await _client.post(_uri(path, query), headers: await _authHeaders(), body: jsonEncode(body ?? {}));
    return _handle(res);
  }

  dynamic _handle(http.Response res) {
    // Server always returns 200 with a JSON that has { status: 0|1, msg?, data? }
    final decoded = jsonDecode(res.body);
    final status = decoded['status'] as int? ?? 1;
    if (status == 1) {
      final msg = decoded['msg']?.toString() ?? 'Ocurrió un error';
      ToastService.showTop(msg);
      throw ApiError(message: msg, data: decoded);
    }
    return decoded['data'];
  }

  void close() => _client.close();
}

class ApiError implements Exception {
  final String message;
  final dynamic data;
  ApiError({required this.message, this.data});
  @override
  String toString() => message;
}
