import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/core/constants/endpoints.dart';
import 'package:medio_ambiente_app/models/media.dart';


class MedidasRepository {
  final ApiService api;
  MedidasRepository(this.api);

  Future<List<Medida>> fetch() async {
    final json = await api.getJson(Endpoints.medidas);
    final list = (json['data'] ?? json['medidas'] ?? []) as List;
    return list.map((e) => Medida.fromJson(e as Map<String, dynamic>)).toList();
  }
}
