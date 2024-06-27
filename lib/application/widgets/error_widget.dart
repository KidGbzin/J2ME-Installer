import 'package:flutter/material.dart';

import '../core/enumerations/palette_enumeration.dart';
import '../core/enumerations/typographies_enumeration.dart';

class ErrorView extends StatelessWidget {
  const ErrorView(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Text(
          message,
          style: Typographies.body(Palette.elements).style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}