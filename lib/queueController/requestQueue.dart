// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:coba_coba/main.dart';
import 'package:coba_coba/singleton_connection.dart';

class queuesRequest {
  static addQueue(data) async {
    reqsss.add(data);
    while (reqsss.isNotEmpty) {
      Uint8List dataNext = reqsss.removeFirst();
      // await Streams.addData(dataNext);
      await RabbitMqConnection.sendnreceivemassage(
        dataNext,
        clientTag,
      );
    }
  }
}
