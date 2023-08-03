import 'dart:math';

class RandomGenerate {
  static String generateRandomTag(int length) {
    final Random random = Random();

    const String characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

    String tag = '';
    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(characters.length);
      tag += characters[randomIndex];
    }

    return "Client.$tag";
  }
}
