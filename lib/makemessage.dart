import 'dart:typed_data';

import 'constant.dart';

class makeMassage2 {
  static makeHeader(int length, int packageId) {
    final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
    Uint8List headers = Uint8List(PACKAGE_HEADER_LENGTH);
    ByteData byteData = headers.buffer.asByteData();

    byteData.setUint32(0, Constans.PKG_SIGNATURE); // Pkg Signature
    byteData.setUint32(4, length); // Pkg Length
    byteData.setUint16(8, packageId); // Pkg Id
    byteData.setUint16(10, 0); // Common Flags
    byteData.setUint16(12, 0); // Error Code
    byteData.setUint32(14, 0); // Reserved

    return headers;
  }

  static makeMassages(String clientTag, int packageIds) {
    int length = Constans.PACKAGE_HEADER_LENGTH + 2 + clientTag.length;
    Uint8List makeMassages = Uint8List(length);
    ByteData dataBuffer = makeMassages.buffer.asByteData();
    Uint8List makeHeaders = makeHeader(length, packageIds);
    for (int i = 0; i < makeHeaders.length; i++) {
      dataBuffer.setUint8(i, makeHeaders[i]);
    }

    dataBuffer.setUint16(Constans.PACKAGE_HEADER_LENGTH, clientTag.length);
    for (int o = 0; o < clientTag.length; o++) {
      dataBuffer.setUint8(18 + 2 + o, clientTag.codeUnitAt(o));
    }

    return makeMassages;
  }

  static Uint8List createIndexMemberListRequesr(
      String clientTag, int packageId, String indexName) {
    final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
    final int headerLength =
        PACKAGE_HEADER_LENGTH + 2 + clientTag.length + 2 + indexName.length;
    int readpos = 0;

    Uint8List indexMemberListRequest = Uint8List(headerLength);
    ByteData bb = indexMemberListRequest.buffer.asByteData();

    Uint8List packageHeader = makeHeader(headerLength, packageId);
    for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
      bb.setUint8(i, packageHeader[i]);
    }

    readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;

    bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
    for (int i = 0; i < clientTag.length; i++) {
      bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
    }
    readpos = readpos + clientTag.length + 2;
    bb.setUint16(readpos, indexName.length);
    for (int i = 0; i < indexName.length; i++) {
      bb.setUint8(readpos + 2 + i, indexName.codeUnitAt(i));
    }
    readpos = readpos + indexName.length;

    print(indexMemberListRequest);
    return indexMemberListRequest;
  }

  static Uint8List createEncryptedMessage(
      int packageId, Uint8List data, int xlength) {
    // Lakukan enkripsi terhadap data yang mau dikirim
    // Uint8List encryptedData = encrypt(data);

    // Simpan data package header + panjang data + encrypted data ke dalam Uint8List
    Uint8List request = Uint8List(Constans.PACKAGE_HEADER_LENGTH + xlength + 4);
    int offset = 0;

    // Package Header
    Uint8List packageHeader =
        makeHeader(Constans.PACKAGE_HEADER_LENGTH + xlength, packageId);
    request.setRange(
        offset, offset + Constans.PACKAGE_HEADER_LENGTH, packageHeader);
    offset += Constans.PACKAGE_HEADER_LENGTH;

    // Pkg Length
    // Uint8List pkgLength = Uint8List(4)
    //   ..buffer.asByteData().setUint32(0, xlength, Endian.big);
    // request.setRange(offset, offset + 4, pkgLength);
    // offset += 4;

    // Encrypted Data
    request.setRange(offset, offset + xlength, data);
    // print(request);
    return request;
  }

  static Uint8List createLoginRequst({
    required String clientTag,
    required String loginId,
    required String loginPassword,
    String imei = "",
    String phoneNo = "",
  }) {
    int xlength = clientTag.length +
        loginId.length +
        loginPassword.length +
        imei.length +
        phoneNo.length +
        10;
    // pastikan bahwa panjang data merupakan kelipatan 16
    if ((xlength % 16) != 0) {
      xlength = xlength + (16 - (xlength % 16));
    }

    // simpan data yang mau dikirim kedalam list of byte
    Uint8List data = Uint8List(xlength);
    ByteData bbData = data.buffer.asByteData();

    bbData.setUint16(
        0, clientTag.length, Endian.big); // Client Tag Len	Unsigned Short	2
    for (int i = 0; i < clientTag.length; i++) {
      bbData.setUint8(
          2 + i, clientTag.codeUnitAt(i)); // Client Tag	Char	64	Max 63 chars
    }

    int offset = 2 + clientTag.length;

    bbData.setUint16(
        offset, loginId.length, Endian.big); // Login Id Len	Unsigned Short	2
    offset += 2;
    for (int i = 0; i < loginId.length; i++) {
      bbData.setUint8(
          offset + i, loginId.codeUnitAt(i)); // Login Id	char	30	Max 30 chars
    }

    offset += loginId.length;

    bbData.setUint16(offset, loginPassword.length,
        Endian.big); // Login Password Len	Unsigned Short	2
    offset += 2;
    for (int i = 0; i < loginPassword.length; i++) {
      bbData.setUint8(
          offset + i,
          loginPassword
              .codeUnitAt(i)); // Login Password	Unsigned Short	15	Max 15 chars
    }

    offset += loginPassword.length;

    bbData.setUint16(
        offset, imei.length, Endian.big); // IMEI Len	Unsigned Short	2
    offset += 2;
    for (int i = 0; i < imei.length; i++) {
      bbData.setUint8(offset + i, imei.codeUnitAt(i)); // IMEI	char	64
    }

    offset += imei.length;

    bbData.setUint16(
        offset, phoneNo.length, Endian.big); // PhoneNo Len	Unsigned Short	2
    offset += 2;
    for (int i = 0; i < phoneNo.length; i++) {
      bbData.setUint8(offset + i, phoneNo.codeUnitAt(i)); // Phone No	char	64
    }

    return createEncryptedMessage(Constans.PACKAGE_ID_LOGIN, data, xlength);
  }

  static Uint8List createOrderBookRequesr(String clientTag, int packageId,
      String stockCode, String commant, String board) {
    final int PACKAGE_HEADER_LENGTH = Constans.PACKAGE_HEADER_LENGTH;
    final int headerLength = PACKAGE_HEADER_LENGTH +
        8 +
        clientTag.length +
        commant.length +
        stockCode.length +
        board.length;
    int readpos = 0;

    Uint8List indexMemberListRequest = Uint8List(headerLength);
    ByteData bb = indexMemberListRequest.buffer.asByteData();

    Uint8List packageHeader = makeHeader(headerLength, packageId);
    for (int i = 0; i < PACKAGE_HEADER_LENGTH; i++) {
      bb.setUint8(i, packageHeader[i]);
    }

    readpos = readpos + Constans.PACKAGE_HEADER_LENGTH;

    bb.setUint16(PACKAGE_HEADER_LENGTH, clientTag.length);
    for (int i = 0; i < clientTag.length; i++) {
      bb.setUint8(PACKAGE_HEADER_LENGTH + 2 + i, clientTag.codeUnitAt(i));
    }
    readpos = readpos + clientTag.length + 2;

    bb.setUint8(readpos, int.parse(commant));

    readpos = readpos + 1;

    bb.setUint16(readpos, stockCode.length);
    for (int i = 0; i < stockCode.length; i++) {
      bb.setUint8(readpos + 2 + i, stockCode.codeUnitAt(i));
    }
    readpos = readpos + stockCode.length + 2;

    for (int i = 0; i < board.length; i++) {
      bb.setInt8(readpos + i, board.codeUnitAt(i));
    }
    // print(indexMemberListRequest);
    return indexMemberListRequest;
  }
}
