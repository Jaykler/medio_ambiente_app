import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/core/services/storage_service.dart';
import 'package:medio_ambiente_app/core/constants/endpoints.dart';

class AuthRepository {
  final ApiService api;
  final StorageService storage;
  AuthRepository(this.api, this.storage);

  Future<String> login({required String email, required String password}) async {
    final json = await api.postJson(Endpoints.login, {'correo': email, 'clave': password});
    final ok = (json['ok'] == true) || (json['success'] == true);
    if (!ok) throw Exception(json['mensaje'] ?? json['error'] ?? 'Credenciales inválidas');
    final token = (json['token'] ?? json['data']?['token'] ?? '') as String;
    if (token.isEmpty) throw Exception('Token no recibido');
    await storage.saveToken(token);
    return token;
  }

  Future<void> registerVolunteer({
    required String cedula,
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String telefono,
  }) async {
    final json = await api.postJson(Endpoints.register, {
      'cedula': cedula,
      'nombre': nombre,
      'apellido': apellido,
      'correo': correo,
      'password': password,
      'telefono': telefono,
    });
    final ok = (json['ok'] == true) || (json['success'] == true);
    if (!ok) throw Exception(json['mensaje'] ?? 'No se pudo registrar');
  }

  Future<void> logout() async => storage.clearToken();
}
