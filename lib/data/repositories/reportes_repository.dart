import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/core/constants/endpoints.dart';
import 'package:medio_ambiente_app/models/reporte.dart';

class ReportesRepository {
  final ApiService api;
  ReportesRepository(this.api);

  Future<void> crearReporte(Reporte r) async {
    final json = await api.postJson(Endpoints.reportar, r.toJson());
    final ok = (json['ok'] == true) || (json['success'] == true);
    if (!ok) throw Exception(json['mensaje'] ?? 'No se pudo enviar el reporte');
  }

  Future<List<Reporte>> misReportes() async {
    final json = await api.getJson(Endpoints.misReportes);
    final list = (json['data'] ?? json['reportes'] ?? []) as List;
    return list.map((e) => Reporte.fromJson(e as Map<String, dynamic>)).toList();
  }
}
