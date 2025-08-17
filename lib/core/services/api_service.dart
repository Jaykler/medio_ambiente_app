import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base del API (ajustable desde .env si decides usar flutter_dotenv)
  static const String baseUrl = 'https://adamix.net/medioambiente/';

  Future<Map<String, dynamic>> getJson(String path) async {
    final uri = Uri.parse('${baseUrl.trim()}$path');
    final resp = await http.get(uri, headers: {
      'Accept': 'application/json',
    });
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body) as Map<String, dynamic>;
    }
    throw Exception('Error HTTP ${resp.statusCode} → ${resp.body}');
  }
}