// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:typed_data';

import 'package:coba_coba/Getxcontroller/queueController.dart';
import 'package:coba_coba/constant.dart';
import 'package:coba_coba/main.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:get/get.dart';
import 'dart:collection' as qus;

import 'package:synchronized/synchronized.dart';

import 'helper/encryptheader.dart';

var quss = qus.Queue();
var reqsss = qus.Queue();
var responqueue = qus.Queue();
final Lock _lock = Lock();
Uint8List buf = Uint8List(0);
RxList<QueueModelController> listQueueonAdd = <QueueModelController>[].obs;

final contrller = Get.put(QueueController());

class RabbitMqConnection {
  static RabbitMqConnection? _instance;
  static late Channel _connection;
  static late Queue _queue;
  static late Channel _crealtime;
  static late Queue _queuerealtimesaved;
  static late Queue _queueRequest;
  static RxBool isRun = false.obs;
  static RxBool isRunReq = false.obs;
  RabbitMqConnection._();

  static Future<RabbitMqConnection?> getInstance() async {
    if (_instance == null) {
      _instance = RabbitMqConnection._();
      await _instance!._connect();
      await _instance!.queues();
    }
    consumer();
    contrller;
    return _instance;
  }

  static Queue queue() {
    return _queue;
  }

// realtime
  // Future<void> _connectionrealtime() async {
  //   String host = "10.249.250.137";
  //   int port = 5672;

  //   String username = 'user';
  //   String password = 'user';

  //   Client connections = Client(
  //       settings: ConnectionSettings(
  //     host: host,
  //     port: port,
  //     authProvider: AmqPlainAuthenticator(username, password),
  //   ));

  //   _crealtime = await connections.channel();
  //   if (_crealtime != null) {
  //     print(_connectionrealtime);
  //   } else {
  //     print("connection belum dapat");
  //   }
  // }

  // lain

// lain

  // static void cekExistingQueueuOnlist(String queueName) {
  //   if (listQueueonAdd.length != 0 || listQueueonAdd.isNotEmpty) {
  //     for (int i = 0; i < listQueueonAdd.length; i++) {
  //       final existQueue =
  //           listQueueonAdd.any((element) => element.queueName == queueName);

  //       if (!existQueue) {
  //         listQueueonAdd.add(QueueModelController(queueName: queueName));
  //         print(
  //             "Queue tidak sama,  add : ${listQueueonAdd[0].queueName} sama dengan queue baru : $queueName");
  //       } else {
  //         print(
  //             "Queue sama, jangan add : ${listQueueonAdd[0].queueName} sama dengan queue baru : $queueName");
  //       }
  //     }
  //   } else {
  //     listQueueonAdd.add(QueueModelController(queueName: queueName));
  //   }
  // }

  static Future exchangesrealtime(String route) async {
    Exchange exchange = await _crealtime.exchange(
        Constans.EXCHANGE_NAME_REALTIME, Constans.EXCHANGE_TYPE_REALTIME);

    Queue queue = await _crealtime.queue(
      "INIQUEUEREALTIMEDAYAT",
    );

    if (isRun.value == false) {
      _queuerealtimesaved = queue;
      await _queuerealtimesaved.bind(exchange, route);

      isRun.toggle();
    } else {
      await _queuerealtimesaved.bind(exchange, route);
    }
    print("Ini queue ngya diBIND : ${_queuerealtimesaved.name}");
    // cekExistingQueueuOnlist(_queuerealtimesaved.name);

    await _queuerealtimesaved.consume(noAck: true).then(
          (Consumer consumer) => consumer.listen(
            (AmqpMessage M) {
              print("Ini realtime ${M.routingKey}");
            },
          ),
        );
  }

  static Future exchangesrealtimeUnbind(
    String unbid,
  ) async {
    Exchange exchange = await _crealtime.exchange(
        Constans.EXCHANGE_NAME_REALTIME, Constans.EXCHANGE_TYPE_REALTIME);

    Queue queue = _queuerealtimesaved;
    print("Ini queue nya diUNBIND : ${queue.name}");
    await queue.unbind(exchange, unbid);
  }

  static Future removeQueue() async {
    Queue queue = _queuerealtimesaved;
    print("Ini queue nya diUNBIND : ${queue.name}");
    await queue.delete();
    isRun.toggle();
  }

  static Future removeQueueReq() async {
    Queue queue = _queueRequest;
    print("Ini queue nya diUNBIND REQUEST : ${queue.name}");
    await queue.delete();
    isRunReq.toggle();
  }

// bawah

  Future<void> _connect() async {
    String host = "10.249.250.137";
    int port = 5672;

    String username = 'user';
    String password = 'user';

    Client connections = Client(
        settings: ConnectionSettings(
      reconnectWaitTime: const Duration(seconds: 10),
      connectionName: "INICONSUMERNAME",
      host: host,
      port: port,
      authProvider: AmqPlainAuthenticator(username, password),
    ));

    _connection = await connections.channel();
    _crealtime = await connections.channel();
    if (_connection != null) {
      print(_connection);
    } else {
      print("connection belum dapat");
    }
    if (_crealtime != null) {
      print(_crealtime);
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
    Exchange exchange =
        await _connection.exchange("IDX_TASK", ExchangeType.DIRECT);

    exchange.publish(message, routingKey);

    Queue queue = await _connection.queue(clientTag);

    await queue.bind(exchange, clientTag);

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
      final exchange =
          await _connection.exchange(exchangeName, ExchangeType.DIRECT);

      // Membuat dan mengirim pesan

      exchange.publish(message, routingKey);

      // Membuat dan mengikat queue
      Queue queue = await _connection.queue(clientTag);
      await queue.bind(exchange, clientTag);

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
    Exchange exchange = await _connection.exchange(
      Constans.EXCHANGE_NAME_REQUEST,
      Constans.EXCHANGE_TYPE_REQUEST,
    );
    Queue queue = await _connection.queue(clientTag);
    if (isRunReq.value == false) {
      _queueRequest = queue;
      await _queueRequest.bind(exchange, clientTag);
      exchange.publish(message, Constans.QUEUE_NAME_REQUEST);
      isRunReq.toggle();
    } else {
      await _queueRequest.bind(exchange, clientTag);
      exchange.publish(message, Constans.QUEUE_NAME_REQUEST);
    }
    print("INi queue Request : ${_queueRequest.name}");
    await _queueRequest.consume(noAck: true).then(
          (Consumer value) => value.listen(
            (AmqpMessage M) {
              print(M.routingKey);
              responqueue.add(M.payload);
              Uint8List UI = Uint8List.view(M.payload!.buffer);
              PackageHeaders(buf: UI);
            },
          ),
        ); // await queue.bind(_exchange, clientTag);
    // _exchange.publish(message, Constans.QUEUE_NAME_REQUEST);
    // cekExistingQueueuOnlist(queue.name);
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
