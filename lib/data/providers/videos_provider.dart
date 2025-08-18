import 'package:medio_ambiente_app/data/repositories/videos_repository.dart';
import 'package:medio_ambiente_app/data/providers/base_list_provider.dart';
import 'package:medio_ambiente_app/models/video_item.dart';

class VideosProvider extends BaseListProvider<VideoItem> {
  final VideosRepository repo;
  VideosProvider(this.repo);

  Future<void> load() => safeLoad(repo.fetch);
}
