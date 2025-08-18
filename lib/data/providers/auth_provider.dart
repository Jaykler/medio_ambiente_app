import 'package:flutter/foundation.dart';
import 'package:medio_ambiente_app/data/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository repo;
  AuthProvider(this.repo);

  bool _loading = false;
  String? _token;
  String? _error;

  bool get loading => _loading;
  bool get isLogged => _token != null && _token!.isNotEmpty;
  String? get error => _error;

  Future<void> login(String email, String pass) async {
    _loading = true; _error = null; notifyListeners();
    try {
      _token = await repo.login(email: email, password: pass);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }

  Future<void> logout() async {
    await repo.logout();
    _token = null;
    notifyListeners();
  }

  Future<void> registerVolunteer({
    required String cedula,
    required String nombre,
    required String apellido,
    required String correo,
    required String password,
    required String telefono,
  }) async {
    _loading = true; _error = null; notifyListeners();
    try {
      await repo.registerVolunteer(
        cedula: cedula, nombre: nombre, apellido: apellido,
        correo: correo, password: password, telefono: telefono,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }
}
