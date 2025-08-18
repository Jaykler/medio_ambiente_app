import 'package:medio_ambiente_app/data/repositories/servicios_repository.dart';
import 'package:medio_ambiente_app/data/providers/base_list_provider.dart';
import 'package:medio_ambiente_app/models/servicio.dart';

class ServiciosProvider extends BaseListProvider<Servicio> {
  final ServiciosRepository repo;
  ServiciosProvider(this.repo);

  Future<void> load() => safeLoad(repo.fetch);
}
