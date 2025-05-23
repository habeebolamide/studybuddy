import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://da12-41-242-65-1.ngrok-free.app/api/v1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ))
    ..interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get token from local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // print('[RESPONSE] => STATUS: ${response.statusCode}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // print('[ERROR] => ${e.response?.statusCode}: ${e.message}');
        return handler.next(e);
      },
    ));

  static Dio get instance => _dio;
}
