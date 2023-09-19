
import 'native_opencv_windows_platform_interface.dart';

class NativeOpencvWindows {
  Future<String?> getPlatformVersion() {
    return NativeOpencvWindowsPlatform.instance.getPlatformVersion();
  }
}
