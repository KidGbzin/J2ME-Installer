import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import '../interfaces/bucket_interface.dart';

/// A file manager service to handle the device cache files.
class Android implements IAndroid {
  
  /// Read a file from the application's folder.
  @override
  Future<File> read({
    required String document,
    required String folder,
  }) async {
    final Directory? root = await getExternalStorageDirectory();
    final Directory directory = Directory('${root!.path}/$folder')..createSync(
      recursive: true,
    );
    final File file = File('${directory.path}/$document');
    return file;
  }

  /// Write a file on the application's folder.
  @override
  Future<File> write({
    required Uint8List bytes,
    required String document,
    required String folder,
  }) async {
    final Directory? root = await getExternalStorageDirectory();
    final Directory directory = Directory('${root!.path}/$folder')..createSync(
      recursive: true,
    );
    final File file = File('${directory.path}/$document');
    return file.writeAsBytes(bytes);
  }
}