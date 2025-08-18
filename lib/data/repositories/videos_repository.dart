import 'package:medio_ambiente_app/core/services/api_service.dart';
import 'package:medio_ambiente_app/core/constants/endpoints.dart';
import 'package:medio_ambiente_app/models/video_item.dart';

class VideosRepository {
  final ApiService api;
  VideosRepository(this.api);

  Future<List<VideoItem>> fetch() async {
    final json = await api.getJson(Endpoints.videos);
    final list = (json['data'] ?? json['videos'] ?? []) as List;
    return list.map((e) => VideoItem.fromJson(e as Map<String, dynamic>)).toList();
  }
}
