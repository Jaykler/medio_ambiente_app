import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/core/constants/endpoints.dart';
import 'package:medio_ambiente_app/models/noticia.dart';

class NoticiasRepository {
  final ApiService api;
  NoticiasRepository(this.api);

  Future<List<Noticia>> fetch() async {
    final json = await api.getJson(Endpoints.noticias);
    final list = (json['data'] ?? json['noticias'] ?? []) as List;
    return list.map((e) => Noticia.fromJson(e as Map<String, dynamic>)).toList();
  }
}
