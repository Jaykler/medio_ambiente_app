import 'package:flutter/foundation.dart';

class BaseListProvider<T> with ChangeNotifier {
  List<T> _items = [];
  bool _loading = false;
  String? _error;

  List<T> get items => _items;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> safeLoad(Future<List<T>> Function() loader) async {
    _loading = true; _error = null; notifyListeners();
    try {
      _items = await loader();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false; notifyListeners();
    }
  }
}
