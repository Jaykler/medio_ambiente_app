import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/core/constants/endpoints.dart';
import 'package:medio_ambiente_app/models/miembro_equipo.dart';

class EquipoRepository {
  final ApiService api;
  EquipoRepository(this.api);

  Future<List<MiembroEquipo>> fetch() async {
    final json = await api.getJson(Endpoints.equipo);
    final list = (json['data'] ?? json['equipo'] ?? []) as List;
    return list.map((e) => MiembroEquipo.fromJson(e as Map<String, dynamic>)).toList();
  }
}
