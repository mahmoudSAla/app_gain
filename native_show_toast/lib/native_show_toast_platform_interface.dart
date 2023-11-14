import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_show_toast_method_channel.dart';

abstract class NativeShowToastPlatform extends PlatformInterface {
  /// Constructs a NativeShowToastPlatform.
  NativeShowToastPlatform() : super(token: _token);

  static final Object _token = Object();

  static NativeShowToastPlatform _instance = MethodChannelNativeShowToast();

  /// The default instance of [NativeShowToastPlatform] to use.
  ///
  /// Defaults to [MethodChannelNativeShowToast].
  static NativeShowToastPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NativeShowToastPlatform] when
  /// they register themselves.
  static set instance(NativeShowToastPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
