import 'package:flutter/foundation.dart';
import 'package:medio_ambiente_app/data/repositories/areas_repository.dart';
import 'package:medio_ambiente_app/models/area_protegida.dart';

class AreasProvider with ChangeNotifier {
  final AreasRepository repo;
  AreasProvider(this.repo);

  List<AreaProtegida> _items = [];
  bool _loading = false;
  String? _error;

  List<AreaProtegida> get items => _items;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    _loading = true; _error = null; notifyListeners();
    try {
      _items = await repo.fetchAreas();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }
}