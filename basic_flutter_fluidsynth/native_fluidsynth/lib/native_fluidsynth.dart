
import 'dart:async';

import 'package:flutter/services.dart';

class NativeFluidsynth {
  static const MethodChannel _channel =
      const MethodChannel('native_fluidsynth');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
