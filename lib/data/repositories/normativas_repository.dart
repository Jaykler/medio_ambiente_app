import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/models/normativa.dart';

class NormativasRepository {
  final ApiService api;
  NormativasRepository(this.api);

  Future<List<Normativa>> fetchNormativas() async {
    // Ajusta el path según la documentación oficial del API
    final json = await api.getJson('api/normativas');
    final list = (json['data'] ?? json['normativas'] ?? []) as List;
    return list.map((e) => Normativa.fromJson(e as Map<String, dynamic>)).toList();
  }
}