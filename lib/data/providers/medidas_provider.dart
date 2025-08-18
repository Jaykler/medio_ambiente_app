import 'package:medio_ambiente_app/data/repositories/medidas_repository.dart';
import 'package:medio_ambiente_app/data/providers/base_list_provider.dart';
import 'package:medio_ambiente_app/models/media.dart';

class MedidasProvider extends BaseListProvider<Medida> {
  final MedidasRepository repo;
  MedidasProvider(this.repo);

  Future<void> load() => safeLoad(repo.fetch);
}
