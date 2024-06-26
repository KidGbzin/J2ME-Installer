import 'dart:typed_data';

abstract class IClient {
  Future<Uint8List> get(String source);
}