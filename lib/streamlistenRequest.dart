import 'dart:async';

import 'package:coba_coba/singleton_connection.dart';

import 'constant.dart';
import 'main.dart';

late StreamSubscription _subscription;

class Streams {
  static StreamSink sink = controller.sink;
  static Stream stream = controller.stream;

  static addData(dynamic data) async {
    _subscription.resume();
    sink.add(data);
  }

  static controllers() {
    _subscription = stream.listen((event) async {
      if (event != null) {
        await RabbitMqConnection.exchanges(
            event, Constans.QUEUE_NAME_REQUEST, "Test/001");
      }
      if (event == null) {
        _subscription.pause();
      }
    });
  }
}
