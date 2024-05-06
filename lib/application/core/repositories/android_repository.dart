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

  static Future<File> writeTemporary(Uint8List bytes, String fileName) async {
    try {
      final File file = File('${cacheStorage.path}/$fileName');
      return await file.writeAsBytes(bytes);
    }
    catch (error) {
      Logger.error.log('$error');
      throw 'Sorry, the file could not be writed on the device.';
    }
  }

  static Future<File> write(Uint8List bytes, String fileName, String folder) async {
    try {
      final Directory directory = Directory('${externalStorage!.path}/$folder');
      await Directory(directory.path).create();

      final File file = File('${directory.path}/$fileName');
      return await file.writeAsBytes(bytes);
    }
    catch (error) {
      Logger.error.log('$error');
      throw 'Sorry, the file could not be writed on the device.';
    }
  }

  static Future<File> load(String fileName, String folder) async {
    final Directory directory = Directory('${externalStorage!.path}/$folder');

    final File file = File('${directory.path}/$fileName');
  
    return file;
  }
}