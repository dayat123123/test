import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:coba_coba/Getxcontroller/queueController.dart';
import 'package:coba_coba/constant.dart';
import 'package:coba_coba/main.dart';
import 'package:coba_coba/makemessage.dart';
import 'package:coba_coba/queueController/requestQueue.dart';
import 'package:coba_coba/service/snappy.dart';
import 'package:coba_coba/singleton_connection.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ...

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

final DynamicLibrary snappy = DynamicLibrary.open('assets/snappy/snappy.dll');

// Deklarasikan fungsi-fungsi Snappy yang ingin Anda gunakan
typedef snappy_compress_func = Int32 Function(
    Pointer<Utf8> input_data,
    IntPtr input_length,
    Pointer<Utf8> output_buffer,
    Pointer<IntPtr> output_length);

typedef snappy_decompress_func = Int32 Function(
    Pointer<Utf8> compressed_data,
    IntPtr compressed_length,
    Pointer<Utf8> output_buffer,
    Pointer<IntPtr> output_length);

// Impor fungsi-fungsi Snappy untuk digunakan
final snappy_compress = snappy.lookupFunction<
    snappy_compress_func,
    int Function(
        Pointer<Utf8> input_data,
        int input_length,
        Pointer<Utf8> output_buffer,
        Pointer<IntPtr> output_length)>("snappy_compress");

final snappy_decompress = snappy.lookupFunction<
    snappy_decompress_func,
    int Function(
        Pointer<Utf8> compressed_data,
        int compressed_length,
        Pointer<Utf8> output_buffer,
        Pointer<IntPtr> output_length)>("snappy_decompress");

class WWW extends StatefulWidget {
  const WWW({super.key});

  @override
  State<WWW> createState() => _WWWState();
}

class _WWWState extends State<WWW> {
  final controller = Get.put(QueueController());

  @override
  void initState() {
    controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void saveList() async {
      String inputString = "Saya adalah Dayat AJA";
      Uint8List uint8List = Uint8List.fromList(utf8.encode(inputString));
      String encodedData = base64Encode(uint8List);
      print(encodedData);
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/snappy/buy.png'),
          Center(
            child: ElevatedButton(
              onPressed: () {
                saveList();
              },
              child: const Text("SET"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Contoh kompresi dan dekompresi data
                // final input =
                //     'Hello, Snappy!ffkdofkdofkdo kodfkdofkodfko kdofkd odkofkdo kdofk dofkd okdofkodkfod kodk odk ofdkof kdo fkdo kdo kod fkofk od kfodk fodkfo dk odk of';
                // final compressedBuffer = calloc<Uint8>(1024);
                // final compressedLength = calloc<IntPtr>();

                // final decompressedBuffer = calloc<Uint8>(1024);
                // final decompressedLength = calloc<IntPtr>();

                // final inputBuffer = input.toNativeUtf8();
                // final inputLength = inputBuffer.length;

                // // Kompresi data
                // var data = snappy_compress(inputBuffer, inputLength,
                //     compressedBuffer.cast(), compressedLength);

                // Dekompresi data
                // snappy_decompress(
                //     compressedBuffer.cast(),
                //     compressedLength.value,
                //     decompressedBuffer.cast(),
                //     decompressedLength);

                // print('Input: $data');
                // print('Decompressed:  ');
                // print("dd");
                // final compressedLength = Snappy.compress(
                //   nullptr,
                //   dataToCompress.length,
                //   nullptr,
                //   nullptr,
                // );
                // final compressedData = calloc<Uint8>(compressedLength);

                final data = "2323";
                // snappy_compress();
              },
              child: const Text("Restart"),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences data = await SharedPreferences.getInstance();
                data.getString('encodedDataKey');
                print(data);
              },
              child: const Text("GETSTRING"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.OnBindQT('QT.*.*');
                  },
                  child: const Text("BIND QT"),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    RabbitMqConnection.exchangesrealtime('RT.*.*');
                  },
                  child: const Text("BIND RT"),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    RabbitMqConnection.removeQueue();
                    RabbitMqConnection.removeQueueReq();
                  },
                  child: const Text("REMOVE QUEUE"),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    RabbitMqConnection.exchangesrealtimeUnbind('QT.*.*');
                  },
                  child: const Text("UNBIND QT"),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    RabbitMqConnection.exchangesrealtimeUnbind('RT.*.*');
                    // queuesRequest.addQueue(makeMassage2.createLoginRequst(
                    //     clientTag: clientTag,
                    //     loginId: "Dayat",
                    //     loginPassword: "123456"));

                    // queuesRequest.addQueue(makeMassage2.makeMassages(
                    //     clientTag, Constans.PACKAGE_ID_BROKER_LIST));
                  },
                  child: const Text("UNBIND RT"),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // queuesRequest.addQueue(makeMassage2.createLoginRequst(
                    //     clientTag: clientTag,
                    //     loginId: "Dayat",
                    //     loginPassword: "123456"));
                    queuesRequest.addQueue(makeMassage2.makeMassages(
                        clientTag, Constans.PACKAGE_ID_BROKER_LIST));
                  },
                  child: const Text("BROKER LIST"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}      // queuesRequest.addQueue(makeMassage2.createLoginRequst(
                    //     clientTag: clientTag,
                    //     loginId: "Dayat",
                    //     loginPassword: "123456"));

                    // queuesRequest.addQueue(makeMassage2.makeMassages(
                    //     clientTag, Constans.PACKAGE_ID_BROKER_LIST));
     // Center(
              //   child: IconButton(
              //       onPressed: () async {
              //         // ReceivePort receivePort = ReceivePort();
              //         // SendPort sendPort = await receivePort.first;

              //         String aa = RandomGenerate.generateRandomTag(14);
              //         dynamic message = makeMassage2.createLoginRequst(
              //           clientTag: aa,
              //           loginId: "Dayat",
              //           loginPassword: "123456",
              //         );

              //         // final isolate = await Isolate.spawn(
              //         //     isolateEntryPoint, receivePort.sendPort);
              //         // batas
              //         final receivePort = ReceivePort();
              //         final isolate = await Isolate.spawn(
              //             isolateEntryPoint, receivePort.sendPort);
              //         final sendPort = await receivePort.first;

              //         // Send data to the spawned isolate

              //         sendPort.send({'aa': aa, 'messs': message});
              //       },
              //       icon: const Icon(Icons.account_balance)),
              // ),
              // Center(
              //   child: TextButton(
              //     onPressed: () {
              //       queuesRequest.addQueue(makeMassage2.createLoginRequst(
              //           clientTag: clientTag,
              //           loginId: "Dayat",
              //           loginPassword: "123456"));

              //       queuesRequest.addQueue(makeMassage2.makeMassages(
              //           clientTag, Constans.PACKAGE_ID_BROKER_LIST));
              //     },
              //     child: Text("B"),
              //   ),
              // ),
              // GetBuilder<Controller>(
              //     init: Controller(),
              //     // You can initialize your controller here the first time. Don't use init in your other GetBuilders of same controller
              //     builder: (_) => Text(
              //           'clicks: ${_.count}',
              //         )),
              // IconButton(
              //     onPressed: () {
              //       Get.find<Controller>().increment();
              //     },
              //     icon: Icon(Icons.abc)),
              // GetBuilder<Controller>(
              //     init: Controller(),
              //     // You can initialize your controller here the first time. Don't use init in your other GetBuilders of same controller
              //     builder: (_) => _.isViss == false
              //         ? Icon(Icons.abc)
              //         : Icon(Icons.ac_unit)),
// class Controller extends GetxController {
//   int count = 0;
//   bool isViss = true;
//   void increment() {
//     count++;

//     isViss = !isViss;
//     // use update method to update all count variables
//     update();
//   }
// }

// void isolateEntryPoint(SendPort sendPort) async {
//   await RabbitMqConnection.getInstance();
//   final receivePort = ReceivePort();
//   sendPort.send(receivePort.sendPort);
//   receivePort.listen(
//     (message) {
//       final aa = message['aa'];
//       final messs = message['messs'];

//       for (int i = 0; i < 1; i++) {
//         RabbitMqConnection.sendnreceivemassage(messs, aa);
//       }
//     },
//   );
// }

// Future<Channel> createSharedConnection() async {
//   // Ganti URL dengan URL RabbitMQ yang sesuai

//   String host = "10.249.250.137";
//   int port = 5672;

//   String username = 'user';
//   String password = 'user';

//   final Client client = Client(
//       settings: ConnectionSettings(
//     host: host,
//     port: port,
//     authProvider: AmqPlainAuthenticator(username, password),
//   ));

//   return await client.connect();
// }

// Future<void> sendMessageToRabbitMQ(dynamic message, Client con) async {
//   final Channel connection = await con.channel();
//   Exchange exchange = await connection.exchange(
//     Constans.EXCHANGE_NAME_REQUEST,
//     Constans.EXCHANGE_TYPE_REQUEST,
//   );
//   Queue queue = await connection.queue(clientTag);

//   await queue.bind(exchange, clientTag);
//   exchange.publish(message, Constans.QUEUE_NAME_REQUEST);
//   await queue
//       .consume(noAck: true)
//       .then((Consumer value) => value.listen((AmqpMessage M) {
//             print(M.routingKey);
//             responqueue.add(M.payload);
//             Uint8List UI = Uint8List.view(M.payload!.buffer);
//             PackageHeaders(buf: UI);
//           }));
// }

// void isolateFunction(SendPort sendPort) async {
//   Channel connection = await createSharedConnection();
//   sendPort.send(connection);
// }











// sendMSG(SendPort sendPort,
//     {required String aa, required Uint8List messs}) async {
//   final receivePort = ReceivePort();
//   sendPort.send(receivePort.sendPort);
//   receivePort.listen((message) {
//     // Extract data from the message
//     final aa = message['aa'];
//     final messs = message['messs'];

//     // Your logic to process the data inside the spawned isolate
//     RabbitMqConnection.sendnreceivemassage(messs, aa);

//     //   sendPort.send(); // Send back the result to the main isolate
//     // });
//     // var url =
//     //     'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita';
//     // for (int i = 0; i < 3; i++) {
//     //   // var response = await http.get(Uri.parse(url));
//     //   await RabbitMqConnection.sendnreceivemassage(messs, aa);

//     //   // sendPort.send(messs);
//     // }
//   });
//   // Isolate.exit();
// }

// void complexTask2(SendPort sendPort) {
//   for (var i = 0; i < 10; i++) {
//     var total = 0.0;
//     for (var j = 0; j < 1000000000; j++) {
//       total += j;
//     }
//     sendPort.send(total);
//   }
// }

// class IsolateMessage {
//   static sendMSG(SendPort sendPort) async {
//     await RabbitMqConnection.getInstance();
//     // var url =
//     //     'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita';
//     var aa = RandomGenerate.generateRandomTag(14);
//     dynamic messs = makeMassage2.createLoginRequst(
//         clientTag: aa, loginId: "Dayat", loginPassword: "123456");
//     for (int i = 0; i < 3; i++) {
//       // var response = await http.get(Uri.parse(url));
//       await RabbitMqConnection.sendnreceivemassage(messs, aa);

//       // sendPort.send(messs);
//     }
//     Isolate.exit();
//   }
// }
