import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import '../enumerations/logger_enumeration.dart';

class Android {
  static late final Directory cacheStorage;
  static late final Directory? externalStorage;

  static Future<void> initialize() async {
    cacheStorage = await getApplicationCacheDirectory();
    externalStorage = await getExternalStorageDirectory();
  }

  static Future<File> write(Uint8List bytes, String fileName) async {
    try {
      final File file = File('${cacheStorage.path}/$fileName');
      return await file.writeAsBytes(bytes);
    }
    catch (error) {
      Logger.error.log('$error');
      throw 'Sorry, the file could not be writed on the device.';
    }
  }
}