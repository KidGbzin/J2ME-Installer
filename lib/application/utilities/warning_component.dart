import 'package:flutter/material.dart';

import '../core/enumerations/palette_enumeration.dart';
import '../core/enumerations/typographies_enumeration.dart';

class Warning extends SnackBar {
  final String body;

  Warning(this.body, {super.key}) : super(content: Container(
    height: 41,
    margin: const EdgeInsets.all(15),
    width: double.infinity,
    child: Text(
      body,
      style: Typographies.body(Palette.elements).style,
    ),
  ));

  Widget build(BuildContext context) {
    return SnackBar(
      content: content,
      padding: EdgeInsets.zero,
    );
  }
}