import 'dart:isolate';

import 'package:coba_coba/helper/genrandomClientag.dart';
import 'package:coba_coba/makemessage.dart';
import 'package:coba_coba/singleton_connection.dart';

class MyWorker {
  static void sendToRabbitMQ(SendPort sendPort) async {
    bool? stop;
    while (stop == false) {
      // Implementasi pengiriman pesan ke RabbitMQ seperti sebelumnya
      await RabbitMqConnection.getInstance();
      var aa = RandomGenerate.generateRandomTag(14);
      dynamic messs = makeMassage2.createLoginRequst(
          clientTag: aa, loginId: "Dayat", loginPassword: "123456");
      for (int i = 0; i < 3; i++) {
        // var response = await http.get(Uri.parse(url));
        RabbitMqConnection.sendnreceivemassage(messs, aa);

        // sendPort.send(messs);
      }
      // Tunggu selama 1 detik sebelum mengirim pesan berikutnya
      await Future.delayed(Duration(seconds: 1));
    }
    // Kirim pesan penutup ke isolates pemanggil
    sendPort.send('done');
  }
}
