import 'dart:io';

import 'package:flutter/services.dart';

class Activity {
  static const MethodChannel _channel = MethodChannel('br.com.kidgbzin.j2me_loader/install');

  static Future<void> emulator(File file) async => await _channel.invokeMethod('Install', file.path);

  static Future<void> gitHub() async => await _channel.invokeMethod('GitHub');
  
  static Future<void> playStore() async => await _channel.invokeMethod('PlayStore');
}