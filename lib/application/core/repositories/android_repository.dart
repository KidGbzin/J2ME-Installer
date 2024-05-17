import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../enumerations/logger_enumeration.dart';

/// This repository resposible to handle the Android device files.
class Android {
  Android._();

  static final Android _instance = Android._();

  factory Android() => _instance;

  /// The application's cache directory.
  /// 
  /// Used to store temporary data, when the application is closes all files in this directory is lost.
  static late final Directory cache;

  /// The application's external directory.
  /// 
  /// This directory can be acessed by the user at Android folder on the file system.
  static late final Directory? external;

  /// Initialize the Android repository.
  /// 
  /// Gets the application's directory from the Android system.
  static Future<void> initialize() async {
    cache = await getApplicationCacheDirectory();
    external = await getExternalStorageDirectory();
  }
  
  /// Write a [output] file on the device using it's [bytes] and returs it's [File].
  /// 
  /// The device stores files based on the extension type.
  /// For example, a .PNG file is saved in the PNGs folder, a .RTX file is saved in the RTXs folder, and so on.
  /// 
  /// For .JAR files, there is a subfolder with the name of the game as "JARs/Gangstar - Crime City".
  /// So remember to pass the name of the subfolder as well with the .JAR file.
  static Future<File> write(Uint8List bytes, String output) async {
    try {
      output = output.replaceAll(':', ' -'); // Replaces the ':' caracter to ' -', because is a forbidden caracter on file systems.
      final String extension = output.split('.').last.toUpperCase();
      final Directory directory = Directory('${external!.path}/$extension');
      await Directory(directory.path).create();
      final File file = File('${directory.path}/$output');
      return await file.writeAsBytes(bytes);
    }
    catch (error) {
      Logger.error.log('$error');
      throw 'The file "$output" could not be writed on the device.';
    }
  }

  /// Get a [File] from the device using a [source].
  /// 
  /// The device stores files based on the extension type.
  /// For example, a .PNG file is saved in the PNGs folder, a .RTX file is saved in the RTXs folder, and so on.
  /// 
  /// For .JAR files, there is a subfolder with the name of the game as "JARs/Gangstar - Crime City".
  /// So remember to pass the name of the subfolder as well with the .JAR file.
  static Future<File> read(String source) async {
    source = source.replaceAll(':', ' -'); // Replaces the ':' caracter to ' -', because is a forbidden caracter on file systems.
    final String extension = source.split('.').last.toUpperCase();
    final Directory directory = Directory('${external!.path}/$extension');
    final File file = File('${directory.path}/$source');
    return file;
  }
  
  /// Create a temporary file on the cache directory and returns it's [File].
  /// 
  /// Please note that this file will be deleted or overwritten shortly after use.
  static Future<File> temporary(Uint8List bytes) async {
    try {
      final File file = File('${cache.path}/temporary.dat');
      return await file.writeAsBytes(bytes);
    }
    catch (error) {
      Logger.error.log('$error');
      throw 'Sorry, the temporary file could not be writed on the cache.';
    }
  }
}