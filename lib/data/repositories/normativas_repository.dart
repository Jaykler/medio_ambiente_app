import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/models/normativa.dart';
import 'package:medio_ambiente_app/core/constants/endpoints.dart';

class NormativasRepository {
  final ApiService api;
  NormativasRepository(this.api);

  Future<List<Normativa>> fetchNormativas() async {
    final json = await api.getJson(Endpoints.normativas);
    final list = (json['data'] ?? json['normativas'] ?? []) as List;
    return list.map((e) => Normativa.fromJson(e as Map<String, dynamic>)).toList();
  }
}
