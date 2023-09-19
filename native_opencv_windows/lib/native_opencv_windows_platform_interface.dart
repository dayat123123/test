import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_opencv_windows_method_channel.dart';

abstract class NativeOpencvWindowsPlatform extends PlatformInterface {
  /// Constructs a NativeOpencvWindowsPlatform.
  NativeOpencvWindowsPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeOpencvWindowsPlatform _instance = MethodChannelNativeOpencvWindows();

  /// The default instance of [NativeOpencvWindowsPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeOpencvWindows].
  static NativeOpencvWindowsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeOpencvWindowsPlatform] when
  /// they register themselves.
  static set instance(NativeOpencvWindowsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
