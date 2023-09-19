import 'package:flutter_test/flutter_test.dart';
import 'package:native_opencv_windows/native_opencv_windows.dart';
import 'package:native_opencv_windows/native_opencv_windows_platform_interface.dart';
import 'package:native_opencv_windows/native_opencv_windows_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNativeOpencvWindowsPlatform
    with MockPlatformInterfaceMixin
    implements NativeOpencvWindowsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NativeOpencvWindowsPlatform initialPlatform = NativeOpencvWindowsPlatform.instance;

  test('$MethodChannelNativeOpencvWindows is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNativeOpencvWindows>());
  });

  test('getPlatformVersion', () async {
    NativeOpencvWindows nativeOpencvWindowsPlugin = NativeOpencvWindows();
    MockNativeOpencvWindowsPlatform fakePlatform = MockNativeOpencvWindowsPlatform();
    NativeOpencvWindowsPlatform.instance = fakePlatform;

    expect(await nativeOpencvWindowsPlugin.getPlatformVersion(), '42');
  });
}
