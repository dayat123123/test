import 'dart:async';

import 'package:coba_coba/helper/genrandomClientag.dart';
import 'package:coba_coba/homeview.dart';

import 'package:coba_coba/makemessage.dart';
import 'package:coba_coba/pageview/homeview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:coba_coba/singleton_connection.dart';
import 'package:flutter/material.dart';

StreamController controller = StreamController();
dynamic mess;
var clientTag = "";

// ReceivePort receivePort = ReceivePort();
// late final SendPort sendPort = receivePort.first as SendPort;
void main() async {
  // await ada().function();
  await RabbitMqConnection.getInstance();
  // await RabbitMQConnection.instance.connect();
  mess = makeMassage2.createLoginRequst(
      clientTag: clientTag, loginId: "Dayat", loginPassword: "123456");
  clientTag = RandomGenerate.generateRandomTag(14);
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (ctx, child) {
          ScreenUtil.init(ctx);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const WWW(),
          );
        });
  }
}

// class connectionLists {
//   static RabbitMqConnectionLinkedList connectionList =
//       RabbitMqConnectionLinkedList();

//   static connectToRabbitMq() async {
//     String host = "10.249.250.137";
//     int port = 5672;

//     String username = 'user';
//     String password = 'user';

//     Channel connection = await Client(
//         settings: ConnectionSettings(
//       host: host,
//       port: port,
//       authProvider: AmqPlainAuthenticator(username, password),
//     )).connect();

//     connectionList.addConnection(connection);
//   }

//   disconnectFromRabbitMq(Channel connection) {
//     connectionList.removeConnection(connection);
//   }

//   closeAllConnections() {
//     connectionList.closeAllConnections();
//   }
// }

// class makeMassage {
//   static makeHeader(int length, int packageId) {
//     final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
//     Uint8List headers = Uint8List(PACKAGE_HEADER_LENGTH);
//     ByteData byteData = headers.buffer.asByteData();

//     byteData.setUint32(0, Constans.PKG_SIGNATURE); // Pkg Signature
//     byteData.setUint32(4, length); // Pkg Length
//     byteData.setUint16(8, packageId); // Pkg Id
//     byteData.setUint16(10, 0); // Common Flags
//     byteData.setUint16(12, 0); // Error Code
//     byteData.setUint32(14, 0); // Reserved

//     return headers;
//   }

//   static makeMassages(String clientTag, int packageIds) {
//     int length = Constans.PACKAGE_HEADER_LENGTH + 2 + clientTag.length;
//     Uint8List makeMassages = Uint8List(length);
//     ByteData dataBuffer = makeMassages.buffer.asByteData();
//     Uint8List makeHeaders = makeHeader(length, packageIds);
//     for (int i = 0; i < makeHeaders.length; i++) {
//       dataBuffer.setUint8(i, makeHeaders[i]);
//     }

//     dataBuffer.setUint16(Constans.PACKAGE_HEADER_LENGTH, clientTag.length);
//     for (int o = 0; o < clientTag.length; o++) {
//       dataBuffer.setUint8(18 + 2 + o, clientTag.codeUnitAt(o));
//     }

//     return makeMassages;
//   }
// }
 