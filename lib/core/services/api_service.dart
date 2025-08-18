import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/endpoints.dart';
import 'storage_service.dart';

class ApiService {
  final _storage = StorageService();

  Future<Map<String, dynamic>> getJson(String path) async {
    final uri = Uri.parse('${Endpoints.base}$path');
    final token = await _storage.readToken();
    final resp = await http.get(uri, headers: _headers(token));
    return _decode(resp);
  }

  Future<Map<String, dynamic>> postJson(String path, Map<String, dynamic> body) async {
    final uri = Uri.parse('${Endpoints.base}$path');
    final token = await _storage.readToken();
    final resp = await http.post(uri, headers: _headers(token), body: jsonEncode(body));
    return _decode(resp);
  }

  Map<String, String> _headers(String? token) => {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
  };

  Map<String, dynamic> _decode(http.Response r) {
    if (r.statusCode >= 200 && r.statusCode < 300) {
      return (r.body.isEmpty) ? <String, dynamic>{} : jsonDecode(r.body) as Map<String, dynamic>;
    }
    throw Exception('HTTP ${r.statusCode}: ${r.body}');
  }
}
