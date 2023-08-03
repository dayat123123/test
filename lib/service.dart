import 'dart:typed_data';
import 'dart:async';

class ada {
  function() {
    String message = 'Saya belajar Uint8list';
    Uint8List bytes = Uint8List.fromList(message.codeUnits);

    // Menampilkan nilai byte dari Uint8List
    print('Bytes: $bytes');

    // Mengonversi Uint8List menjadi String kembali
    String decodedMessage = String.fromCharCodes(bytes);
    print('Decoded Message: $decodedMessage');
  }

  Future<Uint8List> data() async {
    String data = 'Saya adalah pemula';
    Uint8List bytes = Uint8List.fromList(data.codeUnits);
    return bytes;
  }
}
