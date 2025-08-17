import 'package:flutter/foundation.dart';
import 'package:medio_ambiente_app/data/repositories/normativas_repository.dart';
import 'package:medio_ambiente_app/models/normativa.dart';

class NormativasProvider with ChangeNotifier {
  final NormativasRepository repo;
  NormativasProvider(this.repo);

  List<Normativa> _items = [];
  bool _loading = false;
  String? _error;

  List<Normativa> get items => _items;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    _loading = true; _error = null; notifyListeners();
    try {
      _items = await repo.fetchNormativas();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }
}