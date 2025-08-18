import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/core/constants/endpoints.dart';
import 'package:medio_ambiente_app/models/servicio.dart';

class ServiciosRepository {
  final ApiService api;
  ServiciosRepository(this.api);

  Future<List<Servicio>> fetch() async {
    final json = await api.getJson(Endpoints.servicios);
    final list = (json['data'] ?? json['servicios'] ?? []) as List;
    return list.map((e) => Servicio.fromJson(e as Map<String, dynamic>)).toList();
  }
}
