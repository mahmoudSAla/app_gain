import 'package:flutter/services.dart';

class NativeShowToast {


  static const MethodChannel _channel =
   MethodChannel('native_show_toast');

  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } catch (e) {
      print("Error: $e");
    }
  }
}
