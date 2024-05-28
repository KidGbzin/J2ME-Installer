import 'dart:io';

import 'package:http/http.dart';

import '../entities/jar_entity.dart';

import '../enumerations/folder_enumeration.dart';

import '../services/android_service.dart';
import '../services/github_service.dart';

class Storage {
  /// Tries to get the game's cover from the device system by it's [title].
  /// 
  /// Return the audio as a [File] if exists or throws an error.
  static Future<File> getAudio(String title) async {
    final File file = Android.read(
      folder: Folder.audios.directory(),
      name:'$title.rtx',
    );
    final bool exists = await file.exists(); 
    if (exists) return file;
    final String source = Folder.audios.file(
      file: '$title.rtx',
    );
    final Response response = await GitHub.fetch(source);
    return Android.write(
      bytes: response.bodyBytes,
      folder: Folder.audios.directory(),
      name: "$title.rtx"
    );
  }

  /// Get the cover image from device system as [File] using the game [title].
  /// 
  /// If the cache does not exist, then thies to fetch from GitHub API.
  static Future<File> getCover(String title) async {
    File file = Android.read(
      folder: Folder.covers.directory(),
      name: '$title.png',
    );
    final bool exists = await file.exists();
    if (exists) return file;
    final String source = Folder.covers.file(
      file: "$title.png",
    );
    final Response response = await GitHub.fetch(source);
    file = await Android.write(
      bytes: response.bodyBytes,
      folder: Folder.covers.directory(),
      name: '$title.png',
    );
    return file;
  }

  /// Tries to get the game's icon from the device system by it's [title].
  /// 
  /// Return the cover audio as a [File] if exists.
  static Future<File> getIcon(String title) async {
    File file = Android.read(
      folder: Folder.icons.directory(),
      name: '$title.png',
    );
    final bool exists = await file.exists();
    if (exists) return file;
    final String source = Folder.icons.file(
      file: '$title.png',
    );
    final Response response = await GitHub.fetch(source);
    file = await Android.write(
      bytes: response.bodyBytes,
      folder: Folder.icons.directory(),
      name: '$title.png',
    );
    return file;
  }

  static Future<File> getPackage(JAR jar) async {
    File file = Android.read(
      folder: Folder.packages.directory(
        subfolder: jar.title,
      ),
      name: jar.file,
    );
    final bool exists = await file.exists();
    if (exists) return file;
    final String source = Folder.packages.file(
      file: jar.file,
      subfolder: jar.title,
    );
    final Response response = await GitHub.fetch(source);
    file = await Android.write(
      bytes: response.bodyBytes,
      folder: Folder.packages.directory(
        subfolder: jar.title,
      ),
      name: jar.file,
    );
    return file;
  }
}