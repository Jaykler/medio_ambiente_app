import 'package:medio_ambiente_app/data/repositories/equipo_repository.dart';
import 'package:medio_ambiente_app/data/providers/base_list_provider.dart';
import 'package:medio_ambiente_app/models/miembro_equipo.dart';

class EquipoProvider extends BaseListProvider<MiembroEquipo> {
  final EquipoRepository repo;
  EquipoProvider(this.repo);

  Future<void> load() => safeLoad(repo.fetch);
}
