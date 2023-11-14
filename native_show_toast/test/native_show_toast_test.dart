// import 'package:flutter_test/flutter_test.dart';
// import 'package:native_show_toast/native_show_toast.dart';
// import 'package:native_show_toast/native_show_toast_platform_interface.dart';
// import 'package:native_show_toast/native_show_toast_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// class MockNativeShowToastPlatform
//     with MockPlatformInterfaceMixin
//     implements NativeShowToastPlatform {
//
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }
//
// void main() {
//   final NativeShowToastPlatform initialPlatform = NativeShowToastPlatform.instance;
//
//   test('$MethodChannelNativeShowToast is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelNativeShowToast>());
//   });
//
//   test('getPlatformVersion', () async {
//     NativeShowToast nativeShowToastPlugin = NativeShowToast();
//     MockNativeShowToastPlatform fakePlatform = MockNativeShowToastPlatform();
//     NativeShowToastPlatform.instance = fakePlatform;
//
//     expect(await nativeShowToastPlugin.getPlatformVersion(), '42');
//   });
// }
