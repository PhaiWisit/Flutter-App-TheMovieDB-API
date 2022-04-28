import 'package:flutter/foundation.dart';

class DetailViewModel extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  setLoaging(bool loading) {
    _loading = loading;
  }

  bool _error = false;
  bool get error => _error;
  setError(bool errer) {
    _error = errer;
  }
}
