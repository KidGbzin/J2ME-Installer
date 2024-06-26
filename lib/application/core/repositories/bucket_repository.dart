import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../entities/midlet_entity.dart';

import '../interfaces/bucket_interface.dart';

class Bucket implements IBucket {

  const Bucket({
    required this.android,
    required this.gitHub,
  });

  final IAndroid android;
  final IGitHub gitHub;

  @override
  Future<File> audio(String title) async {
    const String folder = 'Audios';
    final String document = '$title.rtx';
    File file = await android.read(
      folder: folder,
      document: document,
    );
    final bool exists = await file.exists();
    if (!exists) {
      final Uint8List bytes = await gitHub.fetch('$folder/$document');
      file = await android.write(
        bytes: bytes,
        document: document,
        folder: folder,
      );
    }
    return file;
  }

  @override
  Future<File> icon(String title) async {
    const String folder = 'Icons';
    final String document = '$title.png';
    File file = await android.read(
      folder: folder,
      document: document,
    );
    final bool exists = await file.exists();
    if (!exists) {
      final Uint8List bytes = await gitHub.fetch('$folder/$document');
      file = await android.write(
        bytes: bytes,
        document: document,
        folder: folder,
      );
    }
    return file;
  }

  @override
  Future<File> midlet(MIDlet midlet) async {
    final String folder = 'MIDlets/${midlet.title}';
    File file = await android.read(
      folder: folder,
      document: midlet.file,
    );
    final bool exists = await file.exists();
    if (!exists) {
      final Uint8List bytes = await gitHub.fetch('$folder/${midlet.file}');
      file = await android.write(
        bytes: bytes,
        document: midlet.file,
        folder: folder,
      );
    }
    return file;
  }

  @override
  Future<List<Uint8List>> preview(String title) async {
    const String folder = 'Previews';
    final String document = '$title.zip';
    File file = await android.read(
      folder: folder,
      document: document,
    );
    final bool exists = await file.exists();
    if (!exists) {
      final Uint8List bytes = await gitHub.fetch('$folder/$document');
      file = await android.write(
        bytes: bytes,
        document: document,
        folder: folder,
      );
    }
    return _extract(file);
  }

  @override
  Future<File> thumbnail(String title) async {
    const String folder = 'Thumbnails';
    final String document = '$title.png';
    File file = await android.read(
      folder: folder,
      document: document,
    );
    final bool exists = await file.exists();
    if (!exists) {
      final Uint8List bytes = await gitHub.fetch('$folder/$document');
      file = await android.write(
        bytes: bytes,
        document: document,
        folder: folder,
      );
    }
    return file;
  }

  static List<Uint8List> _extract(File package) {
    final List<Uint8List> temporary = <Uint8List> [];
    final Uint8List bytes = package.readAsBytesSync();
    final Archive archive = ZipDecoder().decodeBytes(bytes);
    for (ArchiveFile index in archive) {
      temporary.add(index.content as Uint8List);
    }
    return temporary;
  }
}