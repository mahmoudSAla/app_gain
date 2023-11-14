import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_show_toast_platform_interface.dart';

/// An implementation of [NativeShowToastPlatform] that uses method channels.
class MethodChannelNativeShowToast extends NativeShowToastPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_show_toast');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
