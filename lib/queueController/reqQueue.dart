import 'package:synchronized/synchronized.dart';

class RequestQueue {
  final Lock _lock = Lock();
  final List<String> _requests = [];

  Future<void> addRequest(dynamic request) async {
    await _lock.synchronized(() {
      _requests.add(request);
    });
  }

  Future<String> getNextRequest() async {
    return await _lock.synchronized(() {
      if (_requests.isNotEmpty) {
        return _requests.removeAt(0);
      } else {
        return '';
      }
    });
  }
}
