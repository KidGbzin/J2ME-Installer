import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Cache {
  static late final Box<String> thumbnails;
  static late final Box<String> soundtracks;

  static Future<void> initialize() async {
    final Directory? directory = await getExternalStorageDirectory();
    Hive.defaultDirectory = directory!.path;

    thumbnails = Hive.box<String>(
      maxSizeMiB: 5,
      name: 'thumbnails',
    );

    soundtracks = Hive.box<String>(
      maxSizeMiB: 5,
      name: 'soundtracks',
    );
  }
}