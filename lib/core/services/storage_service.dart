import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<void> saveToken(String token) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('token', token);
  }
  Future<String?> readToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString('token');
  }
}