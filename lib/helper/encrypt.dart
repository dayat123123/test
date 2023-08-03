import 'dart:convert';
import 'dart:typed_data';

// Uint8List bufs = buf;
// String run = routkey;

// Izin edit encrypt.dart untuk coba-coba
class Encrypt {
  //Encrypt 2 bit (getUShort)

  int encrypt2(Uint8List bytes, int offset) {
    int value = (bytes[offset] << 8) | bytes[offset + 1];
    return value;
  }

  // int getPackage2Bit(Uint8List bytes, int offset) {
  //   int value =
  //       ByteData.sublistView(bytes.sublist(offset)).getUint16(0, Endian.big);
  //   return value;
  // }

  //Encrypt 4 bit (getUInt)
  int encrypt4(Uint8List bytes, int offset) {
    int value = (bytes[offset] << 24) |
        (bytes[offset + 1] << 16) |
        (bytes[offset + 2] << 8) |
        bytes[offset + 3];
    return value;
  }

//Encrypt Long
  int getLong(ByteBuffer bb, int pos) {
    ByteData data = bb.asByteData();
    return data.getInt64(pos, Endian.big);
  }

  int getInt(Uint8List bytes, int offset) {
    ByteBuffer get = Uint8List.fromList(bytes).buffer;
    int v = ByteData.view(get).getInt32(offset);
    return v;
  }

//Encrypt Get 1bit
  int get(Uint8List bytes, int offset) {
    return bytes[offset];
  }

  //Encrypt String to binry (getAsciiBytes)
  static Uint8List getAsciiBytes(String value) {
    return Uint8List.fromList(utf8.encode(value));
  }

  //Encrypt binry to String (getAsciiString)
  String getAsciiString(Uint8List bytes, int offset, int len) {
    // Extract the desired portion of the originalData
    Uint8List asciiBytes = bytes.sublist(offset, offset + len);
    // Convert the asciiBytes to a string
    String asciiString = String.fromCharCodes(asciiBytes);
    return asciiString;
  }
}
