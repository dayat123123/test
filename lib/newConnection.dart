import 'dart:typed_data';

import 'package:coba_coba/singleton_connection.dart';
import 'package:dart_amqp/dart_amqp.dart';

import 'constant.dart';
import 'helper/encryptheader.dart';

class RabbitMQConnection {
  static RabbitMQConnection? _instance;
  static late Channel _connection;
  bool _connected = false;

  static Future<RabbitMQConnection?> getInstance() async {
    _instance ??= RabbitMQConnection._();

    return _instance!;
  }

  RabbitMQConnection._();

  Future<void> connect() async {
    if (!_connected) {
      String host = "10.249.250.137";
      int port = 5672;

      String username = 'user';
      String password = 'user';

      Client connections = Client(
          settings: ConnectionSettings(
        host: host,
        port: port,
        authProvider: AmqPlainAuthenticator(username, password),
      ));

      _connection = await connections.channel();

      _connected = true;
    }
  }

  Channel get channel => _connection;

  Future<void> close() async {
    await _connection.close();
    _connected = false;
  }

  static Channel ccc() {
    return _connection;
  }

  static sendnreceivemassagenaru(dynamic message, String clientTag) async {
    // await _lock.synchronized(() async {

    Exchange _exchange = await _connection.exchange(
      Constans.EXCHANGE_NAME_REQUEST,
      Constans.EXCHANGE_TYPE_REQUEST,
    );
    Queue queue = await _connection.queue(clientTag);

    await queue.bind(_exchange, clientTag);
    _exchange.publish(message, Constans.QUEUE_NAME_REQUEST);
    await queue
        .consume(noAck: true)
        .then((Consumer value) => value.listen((AmqpMessage M) {
              print(M.routingKey);
              responqueue.add(M.payload);
              Uint8List UI = Uint8List.view(M.payload!.buffer);
              PackageHeaders(buf: UI);
            }));
    // });
  }
}
