import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_opencv_windows_platform_interface.dart';

/// An implementation of [NativeOpencvWindowsPlatform] that uses method channels.
class MethodChannelNativeOpencvWindows extends NativeOpencvWindowsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_opencv_windows');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
