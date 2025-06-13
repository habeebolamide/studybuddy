import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final Dio _dio = Dio(
      BaseOptions(
        baseUrl: 'https://463d-2c0f-2a80-1-200-e092-4c3d-9706-9d0b.ngrok-free.app/api/v1',
        connectTimeout: const Duration(seconds: 500),
        receiveTimeout: const Duration(seconds: 500),
        headers: {'Content-Type': 'application/json'},
      ),
    )
    ..interceptors.add(
      QueuedInterceptorsWrapper(
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
            print('[ERROR] => DATA: ${e.response?.data}');
            return handler.next(e);
        },
      ),
    );

  static Dio get instance => _dio;
}
