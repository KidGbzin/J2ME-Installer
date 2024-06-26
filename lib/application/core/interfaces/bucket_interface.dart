import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import '../entities/midlet_entity.dart';

abstract class IBucket {
  Future<File> audio(String title);

  Future<File> icon(String title);

  Future<File> midlet(MIDlet midlet);

  Future<List<Uint8List>> preview(String title);

  Future<File> thumbnail(String title);
}

abstract class IAndroid {
  Future<File> read({
    required String document,
    required String folder,
  });

  Future<File> write({
    required Uint8List bytes,
    required String document,
    required String folder,
  });
}