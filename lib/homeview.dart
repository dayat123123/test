import 'dart:async';

import 'dart:isolate';
import 'dart:typed_data';

import 'package:coba_coba/helper/genrandomClientag.dart';
import 'package:coba_coba/makemessage.dart';
import 'package:coba_coba/otherpage.dart';
import 'package:coba_coba/queueController/reqQueue.dart';

import 'package:coba_coba/queueController/requestQueue.dart';
import 'package:coba_coba/singleton_connection.dart';
import 'package:dart_amqp/dart_amqp.dart';

import 'package:flutter/material.dart';
import 'constant.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class WWW extends StatefulWidget {
  const WWW({super.key});

  @override
  State<WWW> createState() => _WWWState();
}

class _WWWState extends State<WWW> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    print("LENG: ${reqsss.length}, DATA: $reqsss");
                  },
                  child: const Text("A"),
                ),
              ),
              Center(
                child: IconButton(
                    onPressed: () async {
                      // ReceivePort receivePort = ReceivePort();
                      // SendPort sendPort = await receivePort.first;

                      String aa = RandomGenerate.generateRandomTag(14);
                      Uint8List messs = makeMassage2.createLoginRequst(
                        clientTag: aa,
                        loginId: "Dayat",
                        loginPassword: "123456",
                      );

                      // final isolate = await Isolate.spawn(
                      //     isolateEntryPoint, receivePort.sendPort);
                      final receivePort = ReceivePort();
                      final isolate = await Isolate.spawn(
                          isolateEntryPoint, receivePort.sendPort);
                      final sendPort = await receivePort.first;

                      // Send data to the spawned isolate

                      sendPort.send({'aa': aa, 'messs': messs});

                      // await Isolate.spawn(complexTask2, receivePort.sendPort);
                      // final receivePort = ReceivePort();

                      // await Isolate.spawn(
                      //     sendMSG(receivePort.sendPort, aa: aa, messs: messs)
                      //         as Future<void> Function(SendPort sendPort),
                      //     receivePort.sendPort);

                      // // Menggunakan for-in loop untuk menerima multiple messages dari isolate
                      // await for (var message in receivePort) {
                      //   print('Total: $message');
                      // }
                      // final receivePort = ReceivePort();
                      // final isolate = await Isolate.spawn(
                      //     isolateEntryPoint, receivePort.sendPort);
                      // final sendPort = await receivePort.first;

                      // // Send data to the isolate
                      // sendPort.send(aa, messs);
                    },
                    icon: const Icon(Icons.account_balance)),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    queuesRequest.addQueue(makeMassage2.createLoginRequst(
                        clientTag: clientTag,
                        loginId: "Dayat",
                        loginPassword: "123456"));

                    queuesRequest.addQueue(makeMassage2.makeMassages(
                        clientTag, Constans.PACKAGE_ID_BROKER_LIST));
                  },
                  child: Text("B"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void isolateEntryPoint(SendPort sendPort) async {
  await RabbitMqConnection.getInstance();
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  receivePort.listen(
    (message) {
      final aa = message['aa'];
      final messs = message['messs'];

      for (int i = 0; i < 200; i++) {
        RabbitMqConnection.sendnreceivemassage(messs, aa);
      }
    },
  );
}

sendMSG(SendPort sendPort,
    {required String aa, required Uint8List messs}) async {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  receivePort.listen((message) {
    // Extract data from the message
    final aa = message['aa'];
    final messs = message['messs'];

    // Your logic to process the data inside the spawned isolate
    RabbitMqConnection.sendnreceivemassage(messs, aa);

    //   sendPort.send(); // Send back the result to the main isolate
    // });
    // var url =
    //     'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita';
    // for (int i = 0; i < 3; i++) {
    //   // var response = await http.get(Uri.parse(url));
    //   await RabbitMqConnection.sendnreceivemassage(messs, aa);

    //   // sendPort.send(messs);
    // }
  });
  // Isolate.exit();
}

void complexTask2(SendPort sendPort) {
  for (var i = 0; i < 10; i++) {
    var total = 0.0;
    for (var j = 0; j < 1000000000; j++) {
      total += j;
    }
    sendPort.send(total);
  }
}

class IsolateMessage {
  static sendMSG(SendPort sendPort) async {
    await RabbitMqConnection.getInstance();
    // var url =
    //     'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita';
    var aa = RandomGenerate.generateRandomTag(14);
    dynamic messs = makeMassage2.createLoginRequst(
        clientTag: aa, loginId: "Dayat", loginPassword: "123456");
    for (int i = 0; i < 3; i++) {
      // var response = await http.get(Uri.parse(url));
      await RabbitMqConnection.sendnreceivemassage(messs, aa);

      // sendPort.send(messs);
    }
    Isolate.exit();
  }
}
