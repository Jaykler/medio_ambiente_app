import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/core/constants/endpoints.dart';
import 'package:medio_ambiente_app/models/area_protegida.dart';

class AreasRepository {
  final ApiService api;
  AreasRepository(this.api);

  Future<List<AreaProtegida>> fetchAreas() async {
    final json = await api.getJson(Endpoints.areas);
    final list = (json['data'] ?? json['areas'] ?? []) as List;
    return list.map((e) => AreaProtegida.fromJson(e as Map<String, dynamic>)).toList();
  }
}
