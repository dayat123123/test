#ifndef FLUTTER_PLUGIN_NATIVE_OPENCV_WINDOWS_PLUGIN_H_
#define FLUTTER_PLUGIN_NATIVE_OPENCV_WINDOWS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace native_opencv_windows {

class NativeOpencvWindowsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  NativeOpencvWindowsPlugin();

  virtual ~NativeOpencvWindowsPlugin();

  // Disallow copy and assign.
  NativeOpencvWindowsPlugin(const NativeOpencvWindowsPlugin&) = delete;
  NativeOpencvWindowsPlugin& operator=(const NativeOpencvWindowsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace native_opencv_windows

#endif  // FLUTTER_PLUGIN_NATIVE_OPENCV_WINDOWS_PLUGIN_H_
