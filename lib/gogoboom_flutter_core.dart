library gogoboom_flutter_core;

import 'dart:async';

import 'package:flutter/services.dart';

class GogoboomFlutterCore {
  static const MethodChannel _channel = MethodChannel('gogoboom_flutter_core');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
