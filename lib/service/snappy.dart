// import 'dart:ffi'; // Import dart:ffi untuk menggunakan FFI

// final DynamicLibrary snappy =
//     DynamicLibrary.open('snappy.dll'); // Gantilah path sesuai lokasi berkas DLL

// // Mendefinisikan fungsi-fungsi dari pustaka Snappy
// // Contoh: Kompresi dan Dekompresi data

// class Snappy {
//   // Fungsi kompresi
//   static int Function(
//     Pointer<Uint8> input,
//     int inputLength,
//     Pointer<Uint8> output,
//     Pointer<Int32> outputLength,
//   ) compress = snappy.lookupFunction<
//       Int32 Function(
//         Pointer<Uint8> input,
//         Int32 inputLength,
//         Pointer<Uint8> output,
//         Pointer<Int32> outputLength,
//       ),
//       int Function(
//         Pointer<Uint8> input,
//         int inputLength,
//         Pointer<Uint8> output,
//         Pointer<Int32> outputLength,
//       )>('snappy_compress');

//   // Fungsi dekompresi
//   static int Function(
//     Pointer<Uint8> input,
//     int inputLength,
//     Pointer<Uint8> output,
//     Pointer<Int32> outputLength,
//   ) uncompress = snappy.lookupFunction<
//       Int32 Function(
//         Pointer<Uint8> input,
//         Int32 inputLength,
//         Pointer<Uint8> output,
//         Pointer<Int32> outputLength,
//       ),
//       int Function(
//         Pointer<Uint8> input,
//         int inputLength,
//         Pointer<Uint8> output,
//         Pointer<Int32> outputLength,
//       )>('snappy_uncompress');
// }

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

final DynamicLibrary snappy = DynamicLibrary.open('snappy.dll');

class Snappy {
  static int Function(
    Pointer<Utf8> input_data,
    int input_length,
    Pointer<Utf8> output_buffer,
    Pointer<IntPtr> output_length,
  ) snappy_compress = snappy.lookupFunction<
      Int32 Function(
        Pointer<Utf8> input_data,
        Int32 input_length,
        Pointer<Utf8> output_buffer,
        Pointer<IntPtr> output_length,
      ),
      int Function(
        Pointer<Utf8> input_data,
        int input_length,
        Pointer<Utf8> output_buffer,
        Pointer<IntPtr> output_length,
      )>('snappy_compress');

  // Fungsi untuk mengompresi data menggunakan Snappy
  static compress(Uint8List input) {
    final input_length = input.length;
    final output_length_ptr = calloc<IntPtr>();

    final output_buffer =
        calloc<Uint8>(input_length * 2); // Estimasi ukuran keluaran
    final output_length = output_length_ptr.value;

    final input_data_ptr = calloc<Uint8>(input_length);
    input_data_ptr.asTypedList(input_length).setAll(0, input);

    final output_data_ptr = output_buffer.cast<Utf8>();

    final result = snappy_compress(input_data_ptr as Pointer<Utf8>,
        input_length, output_data_ptr, output_length_ptr);

    if (result != 0) {
      // throw Exception('Gagal dalam kompresi Snappy');
    }

    // final compressed_data = Uint8List.fromList(List<int>.generate(output_length, (i) => output_data_ptr.cast(i).value));

    calloc.free(input_data_ptr);
    calloc.free(output_buffer);
    calloc.free(output_length_ptr);

    // return compressed_data;
  }
}
