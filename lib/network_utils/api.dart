import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'https://60a8-41-242-65-1.ngrok-free.app/api/v1'; // Android emulator localhost
  String? token;

  Future<void> _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? storedToken = localStorage.getString('token');
    if (storedToken != null) {
      token = jsonDecode(storedToken)['token'];
    }
  }

  Future<http.Response> authData(Map<String, dynamic> data, String apiUrl) async {
    var fullUrl = Uri.parse(_url + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Future<http.Response> getData(String apiUrl) async {
    await _getToken();
    var fullUrl = Uri.parse(_url + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  Map<String, String> _setHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token ?? ''}',
    };
  }
}
