import 'package:flutter/material.dart';

/// A enumeration of colors to be used on the application. \
/// Always use the [Palette] class to set a component color. Check the architecture document for more information.
/// 
/// The parameter [color] is self-explanatory, just the color. It is of type [Color].
enum Palette {
  background(Color(0xff1c1d22)),
  divider(Color(0xff2a2a32)),
  elements(Color(0xffe4e5e9)),
  foreground(Color(0xff26262e)),
  grey(Color(0xFFBDBDBD)),
  primary(Color(0xff50599e)),
  primary2(Color.fromARGB(255, 140, 153, 255)),
  transparent(Color(0x00000000));

  final Color color;

  const Palette(this.color);
}