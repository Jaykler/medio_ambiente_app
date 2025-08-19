import 'package:flutter/foundation.dart';
import 'package:medio_ambiente_app/data/repositories/reportes_repository.dart';
import 'package:medio_ambiente_app/models/reporte.dart';

class MisReportesProvider with ChangeNotifier {
  final ReportesRepository repo;
  MisReportesProvider(this.repo);

  List<Reporte> _items = [];
  bool _loading = false;
  String? _error;

  List<Reporte> get items => _items;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    _loading = true; _error = null; notifyListeners();
    try {
      _items = await repo.misReportes();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }
}
