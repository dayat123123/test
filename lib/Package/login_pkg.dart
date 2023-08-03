// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:coba_coba/constant.dart';
// import 'package:coba_coba/singleton_connection.dart';
// import 'package:online_trading/core/rabbitmq/data_proses.dart';
// import 'package:online_trading/helper/constants.dart';
// import 'package:online_trading/module/model/loginrply_package.dart';
// import 'package:online_trading/module/objectbox/crud/crud_.dart';
// import 'package:online_trading/module/request/encrpty_msg.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// String errorCodeLogin = '';
// getLoginResponse() async {
//   ByteData bb = buf.buffer.asByteData();

//   Uint16List errorCode;
//   errorCode = bb.getUint16(12) as Uint16List; // Error Code	Unsigned Short	2

//   int pos = Constans.PACKAGE_HEADER_LENGTH + 4;
//   Uint8List encryptedData = buf.sublist(pos);
//   Uint8List originalData = decrypt(encryptedData);

//   ByteData originalBB = ByteData.view(originalData.buffer);
//   pos = 0;
//   login.loginIdL = originalBB.getUint16(pos); // Login Id Len	Unsigned Short	2
//   pos += 2;
//   login.loginId = utf8.decode(originalData.sublist(
//       pos, pos + login.loginIdL!.toInt())); // Login Id	char	30	Max 30 chars
//   pos += login.loginIdL!.toInt();
//   login.lotSize = originalBB
//       .getUint32(pos); // LOT SIZE	Unsigned int 	4	Current 1 LOT = 100 Shares
//   if (login.errorCode == 0) {
//     sharedP.setString("loginID", login.loginId.toString());
//     sharedP.setBool("isLogin", true);
//     print(
//         "LoginID: ${login.loginId}, ErrorCode: ${login.errorCode}, LoT: ${login.lotSize}");

//     final object = ObjectBoxDatabase.loginBox;

//     object.put(login);
//   } else {
//     // print("ERROR CODE");
//     // print(login.errorCode.toString());
//   }
//   errorCodeLogin = login.errorCode.toString();
//   print('loginIdL: ${login.loginIdL}');
//   print('loginId: ${login.loginId}');
//   print('lot: ${login.lotSize}');

//   return login;
// }
