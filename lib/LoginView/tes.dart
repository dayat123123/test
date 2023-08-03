import 'package:coba_coba/helper/textcontr.dart';
import 'package:flutter/material.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void hitung(int nilai) {
      for (int i = 1; i <= nilai; i++) {
        if (i % 2 == 0) {
          print("Data : ${i} == Even(Genap)");
        } else {
          print("Data : ${i} == Odd(Ganjil)");
        }
      }
    }

    void spaceDelandLowercase(String input1, String input2) {
      print("Data 1 : ${input1}");
      print("Data 2 : ${input2}");

      String combine = input1.replaceAll(" ", "") + input2.replaceAll(" ", "");

      String hasil = combine.toLowerCase();
      print(
          "Hasil setelah digabung dan hilangin spasi serta ke lowercase : ${hasil}");
    }

    String temp = "";
    void regexdata(String data) {
      StringBuffer datas = StringBuffer();
      temp = data;
      if (data.length == 12) {
        if (temp.startsWith(RegExp(r'[A-Z]'), 0) &&
            temp.startsWith(RegExp(r'[A-Z]'), 1) &&
            temp.startsWith(RegExp(r'[A-Z]'), 2)) {
          print("3 PERTAMA KAPITAL");
        } else {
          print("3 PERTAMA NGGAK KAPITAL");
        }
        for (int i = 0; i < data.length; i++) {
          bool isInput1UpperCase = data[i] == data[i].toUpperCase();
          print("Data : ${data[i]} == ${isInput1UpperCase}");

          // for (int p = 0; p < 2; p++) {
          //   if (isInput1UpperCase != isInput1UpperCase) {
          //     print("data dari 1 sampai 3 harus Uppercase");
          //   }
          // }
        }
      } else {
        print("Data kurang");
      }
    }

    void vaccinevalid(String input) {
      String validinput1 = "ACH100138215";
      String validinput2 = "JKT276238182616";
      String validinput3 = "j3y600238191";

      if (input == validinput1 ||
          input == validinput2 ||
          input == validinput3) {
        print("Right Vaccinatoon Code");
      } else {
        print("Wrong Vaccinaton Code");
      }
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
                        border: InputBorder.none,
                        hintText: "Masukkan datanya "),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            GestureDetector(
              onTap: () async {
                // String text = username_login.text;
                // int data = int.tryParse(text) ?? 0;
                // hitung(data);

                // spaceDelandLowercase(username_login.text, password_login.text);

                regexdata(username_login.text);
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
                        "Proses",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )))),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
