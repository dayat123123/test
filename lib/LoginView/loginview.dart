import 'package:coba_coba/constant.dart';
import 'package:coba_coba/helper/textcontr.dart';
import 'package:coba_coba/main.dart';
import 'package:coba_coba/makemessage.dart';
import 'package:coba_coba/queueController/reqQueue.dart';
import 'package:coba_coba/queueController/requestQueue.dart';
import 'package:coba_coba/singleton_connection.dart';
import 'package:coba_coba/test.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void regLogin() async {
      // RabbitMqConnection.exchanges(
      //     makeMassage2.createLoginRequst(
      //         clientTag: clientTag, loginId: "Dayat", loginPassword: "123456"),
      //     Constans.QUEUE_NAME_REQUEST,
      //     clientTag);
      // queuesRequest.addQueue(makeMassage2.createLoginRequst(
      //     clientTag: clientTag,
      //     loginId: username_login.text,
      //     loginPassword: password_login.text));
      // queuesRequest.addQueue(makeMassage2.createLoginRequst(
      //     clientTag: clientTag,
      //     loginId: username_login.text,
      //     loginPassword: password_login.text));
      // queuesRequest.addQueue(makeMassage2.createLoginRequst(
      //     clientTag: clientTag,
      //     loginId: username_login.text,
      //     loginPassword: password_login.text));
      // LinkedList requestQueue = LinkedList();
      // requestQueue.enqueue(Request('/api/user', {'name': 'John'}));
      // requestQueue.enqueue(Request('/api/product', {'id': 123}));

      // // Membuat linked list untuk antrian respons
      // LinkedList responseQueue = LinkedList();
      // responseQueue.enqueue(Response(200, {'message': 'Success'}));
      // responseQueue.enqueue(Response(404, {'message': 'Not Found'}));

      // // Mengambil dan memproses request dari antrian request
      // while (!requestQueue.isEmpty()) {
      //   Request request = requestQueue.dequeue();
      //   // Proses request ke server
      //   // ...

      //   // Simpan respons ke antrian respons
      //   Response response =
      //       Response(200, {'message': 'Response for ${request.endpoint}'});
      //   responseQueue.enqueue(response);
      // }

      // // Mengambil dan memproses respons dari antrian respons
      // while (!responseQueue.isEmpty()) {
      //   Response response = responseQueue.dequeue();
      //   // Proses respons dari server
      //   print(response.data);
      // }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.2),
              child: const Icon(
                Icons.holiday_village,
                color: Colors.white,
                size: 150,
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    left: size.width * 0.05, right: size.width * 0.03),
                width: size.width * 0.75,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: TextFormField(
                    controller: username_login,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Username"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    left: size.width * 0.05, right: size.width * 0.03),
                width: size.width * 0.75,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  controller: password_login,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Password"),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            GestureDetector(
              onTap: () async {
                // queuesRequest.addQueue(makeMassage2.createLoginRequst(
                //     clientTag: clientTag,
                //     loginId: username_login.text,
                //     loginPassword: password_login.text));
                // queuesRequest.addQueue(makeMassage2.createLoginRequst(
                //     clientTag: clientTag,
                //     loginId: username_login.text,
                //     loginPassword: password_login.text));
                // queuesRequest.addQueue(makeMassage2.createLoginRequst(
                //     clientTag: clientTag,
                //     loginId: username_login.text,
                //     loginPassword: password_login.text));
                // queuesRequest.addQueue(
                //   makeMassage2.createOrderBookRequesr(clientTag,
                //       Constans.PACKAGE_ID_ORDER_BOOK, "ANTM", "1", "RG"),
                // );
                // regLogin();
              },
              child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.only(
                          left: size.width * 0.02, right: size.width * 0.02),
                      width: size.width * 0.6,
                      height: size.height * 0.07,
                      child: const Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )))),
            ),
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () async {
                print(
                    "Ini respon queue dari rabbitmq : leng: ${responqueue.length} ---${responqueue}");
              },
              child: Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.only(
                          left: size.width * 0.02, right: size.width * 0.02),
                      width: size.width * 0.6,
                      height: size.height * 0.07,
                      child: const Center(
                          child: Text(
                        "Print Queue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )))),
            )
          ],
        ),
      ),
    );
  }
}
