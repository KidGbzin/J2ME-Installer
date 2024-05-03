import 'package:flutter/material.dart';

interface class IController extends ChangeNotifier {
  Future<void> initialize() async {}
}