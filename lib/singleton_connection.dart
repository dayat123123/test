// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:typed_data';

import 'package:coba_coba/constant.dart';
import 'package:coba_coba/main.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'dart:collection' as qus;

import 'package:synchronized/synchronized.dart';

import 'helper/encryptheader.dart';

var quss = qus.Queue();
var reqsss = qus.Queue();
var responqueue = qus.Queue();
final Lock _lock = Lock();
Uint8List buf = Uint8List(0);

class RabbitMqConnection {
  static RabbitMqConnection? _instance;
  static late Channel _connection;
  static late Queue _queue;

  // static late Exchange _exchange;

  RabbitMqConnection._();

  static Future<RabbitMqConnection?> getInstance() async {
    if (_instance == null) {
      _instance = RabbitMqConnection._();
      await _instance!._connect();
      await _instance!.queues();
    }
    consumer();

    return _instance;
  }

  static Queue queue() {
    return _queue;
  }

  Future<void> _connect() async {
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
    if (_connection != null) {
      print(_connection);
    } else {
      print("connection belum dapat");
    }
  }

  Future<Queue> queues() async {
    // final Queue queues;
    Exchange exchange = await _connection.exchange(
        Constans.EXCHANGE_NAME_REALTIME, Constans.EXCHANGE_TYPE_REALTIME,
        passive: true, durable: true);

    _queue = await _connection.queue(Constans.QUEUE_NAME_REALTIME).then(
          (Queue queue) => queue.bind(exchange, Constans.ROUTING_KEY),
        );
    return _queue;
  }

  static Future exchanges(message, String routingKey, String clientTag) async {
    Exchange _exchange =
        await _connection.exchange("IDX_TASK", ExchangeType.DIRECT);

    _exchange.publish(message, routingKey);

    Queue queue = await _connection.queue(clientTag);

    await queue.bind(_exchange, clientTag);

    await queue.consume(noAck: true).then(
          (Consumer consumer) => consumer.listen(
            (AmqpMessage M) {
              print("Itu Ini");
            },
          ),
        );
  }

  static consumer() {
    final a = _queue;

    a.consume(consumerTag: a.name).then(
          (Consumer consumer) => consumer.listen(
            (AmqpMessage event) {
              // print(event.routingKey);
              // quss.add(event.routingKey.toString());
            },
          ),
        );
  }

  // fungsi bikin sendiri
  static Future sendMessage(
      String exchangeName, String routingKey, dynamic message) async {
    await _lock.synchronized(() async {
      // Membuat exchange dengan tipe direct
      final _exchange =
          await _connection.exchange(exchangeName, ExchangeType.DIRECT);

      // Membuat dan mengirim pesan

      _exchange.publish(message, routingKey);

      // Membuat dan mengikat queue
      Queue queue = await _connection.queue(clientTag);
      await queue.bind(_exchange, clientTag);

      // Mengonsumsi pesan
      final consumer = await queue.consume(noAck: true);
      consumer.listen((AmqpMessage M) {
        // print(M.payload!);
      });

      // Menutup channel jika diperlukan
      // await channel.close();
    });
  }

  static sendnreceivemassage(dynamic message, String clientTag) async {
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
// import 'dart:async';
// import 'dart:typed_data';

// import 'package:coba_coba/constant.dart';
// import 'package:coba_coba/main.dart';
// import 'package:dart_amqp/dart_amqp.dart';
// import 'dart:collection' as qus;

// import 'package:synchronized/synchronized.dart';

// import 'helper/encryptheader.dart';

// var quss = qus.Queue();
// var reqsss = qus.Queue();
// var responqueue = qus.Queue();
// final Lock _lock = Lock();
// Uint8List buf = Uint8List(0);
// late Channel _connection;

// class RabbitMqConnection {
//   static RabbitMqConnection? _instance;
//   static late Queue _queue;

//   // static late Exchange _exchange;

//   RabbitMqConnection._();

//   static Future<RabbitMqConnection?> getInstance() async {
//     if (_instance == null) {
//       _instance = RabbitMqConnection._();
//       await RabbitMqConnection._connect();
//       await _instance!.queues();
//     }
//     consumer();

//     return _instance;
//   }

//   static Queue queue() {
//     return _queue;
//   }

//   static Future<Channel> channel() async {
//     return _connection = await _connect();
//   }

//   static Future<Channel> _connect() async {
//     String host = "10.249.250.137";
//     int port = 5672;

//     String username = 'user';
//     String password = 'user';

//     Client connections = Client(
//         settings: ConnectionSettings(
//       host: host,
//       port: port,
//       authProvider: AmqPlainAuthenticator(username, password),
//     ));

//     return _connection = await connections.channel();
//     // if (_connection != null) {
//     //   print(_connection);
//     // } else {
//     //   print("connection belum dapat");
//     // }
//   }

//   Future<Queue> queues() async {
//     // final Queue queues;
//     Exchange exchange = await _connection.exchange(
//         Constans.EXCHANGE_NAME_REALTIME, Constans.EXCHANGE_TYPE_REALTIME,
//         passive: true, durable: true);

//     _queue = await _connection.queue(Constans.QUEUE_NAME_REALTIME).then(
//           (Queue queue) => queue.bind(exchange, Constans.ROUTING_KEY),
//         );
//     return _queue;
//   }

//   static Future exchanges(message, String routingKey, String clientTag) async {
//     Channel channels = await channel();
//     Exchange exchange =
//         await channels.exchange("IDX_TASK", ExchangeType.DIRECT);

//     exchange.publish(message, routingKey);

//     Queue queue = await channels.queue(clientTag);

//     await queue.bind(exchange, clientTag);

//     await queue.consume(noAck: true).then(
//           (Consumer consumer) => consumer.listen(
//             (AmqpMessage M) {
//               print("Itu Ini");
//             },
//           ),
//         );
//   }

//   static consumer() {
//     final a = _queue;

//     a.consume(consumerTag: a.name).then(
//           (Consumer consumer) => consumer.listen(
//             (AmqpMessage event) {
//               // print(event.routingKey);
//               // quss.add(event.routingKey.toString());
//             },
//           ),
//         );
//   }

//   // fungsi bikin sendiri
//   static Future sendMessage(
//       String exchangeName, String routingKey, dynamic message) async {
//     Channel channels = await channel();
//     await _lock.synchronized(() async {
//       // Membuat exchange dengan tipe direct
//       final _exchange =
//           await channels.exchange(exchangeName, ExchangeType.DIRECT);

//       // Membuat dan mengirim pesan

//       _exchange.publish(message, routingKey);

//       // Membuat dan mengikat queue
//       Queue queue = await channels.queue(clientTag);
//       await queue.bind(_exchange, clientTag);

//       // Mengonsumsi pesan
//       final consumer = await queue.consume(noAck: true);
//       consumer.listen((AmqpMessage M) {
//         // print(M.payload!);
//       });

//       // Menutup channel jika diperlukan
//       // await channel.close();
//     });
//   }

//   static sendnreceivemassage(dynamic message, String clientTag) async {
//     // await _lock.synchronized(() async {

//     Channel channels = await channel();
//     Exchange _exchange = await channels.exchange(
//       Constans.EXCHANGE_NAME_REQUEST,
//       Constans.EXCHANGE_TYPE_REQUEST,
//     );
//     Queue queue = await channels.queue(clientTag);

//     await queue.bind(_exchange, clientTag);
//     _exchange.publish(message, Constans.QUEUE_NAME_REQUEST);
//     await queue
//         .consume(noAck: true)
//         .then((Consumer value) => value.listen((AmqpMessage M) {
//               print(M.routingKey);
//               responqueue.add(M.payload);
//               Uint8List UI = Uint8List.view(M.payload!.buffer);
//               PackageHeaders(buf: UI);
//             }));
//     // });
//   }
// }
