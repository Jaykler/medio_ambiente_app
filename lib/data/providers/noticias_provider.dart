import 'package:medio_ambiente_app/data/repositories/noticias_repository.dart';
import 'package:medio_ambiente_app/data/providers/base_list_provider.dart';
import 'package:medio_ambiente_app/models/noticia.dart';

class NoticiasProvider extends BaseListProvider<Noticia> {
  final NoticiasRepository repo;
  NoticiasProvider(this.repo);

  Future<void> load() => safeLoad(repo.fetch);
}
