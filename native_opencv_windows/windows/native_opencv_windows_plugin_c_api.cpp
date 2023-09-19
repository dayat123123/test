#include "include/native_opencv_windows/native_opencv_windows_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "native_opencv_windows_plugin.h"

void NativeOpencvWindowsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  native_opencv_windows::NativeOpencvWindowsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
