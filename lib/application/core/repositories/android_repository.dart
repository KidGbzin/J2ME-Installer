import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

/// This repository resposible to handle the Android device files.
class Android {
  Android._();

  static final Android _instance = Android._();

  factory Android() => _instance;

  /// The application's external directory.
  /// 
  /// This directory can be acessed by the user at Android folder on the file system.
  static late final Directory? external;

  /// Initialize the Android repository.
  /// 
  /// Gets the application's directory from the Android system.
  static Future<void> initialize() async {
    external = await getExternalStorageDirectory();
  }

  static File read({
    required String folder,
    required String name,
  }) {
    folder = folder.replaceAll(":", " -");
    name = name.replaceAll(":", " -");
    final Directory directory = Directory('${external!.path}/$folder')..createSync(
      recursive: true,
    );
    final File file = File('${directory.path}/$name');
    return file;
  }

  static Future<File> write({
    required Uint8List bytes,
    required String folder,
    required String name,
  }) {
    folder = folder.replaceAll(":", " -");
    name = name.replaceAll(":", " -");
    final Directory output = Directory('${external!.path}/$folder')..createSync(
      recursive: true,
    );
    final File file = File('${output.path}/$name');
    return file.writeAsBytes(bytes);
  }
}