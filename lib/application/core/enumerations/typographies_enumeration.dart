import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../enumerations/palette_enumeration.dart';

/// A kind of enumeration of text styles to be used on the application. \
/// Always use the [Typographies] class to set a typography. Check the architecture document for more information.
/// 
/// The parameter [style] is the style design of the text. It's of type [TextStyle].
class Typographies {
  final TextStyle style;

  const Typographies._internal(this.style);

  factory Typographies.body(Palette palette) {
    return Typographies._internal(GoogleFonts.rajdhani(
      color: palette.color,
      fontSize: 13,
      fontWeight: FontWeight.normal,
    ));
  }

  factory Typographies.label(Palette palette) {
    return Typographies._internal(GoogleFonts.rajdhani(
      color: palette.color,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ));
  }

  factory Typographies.tile(Palette palette) {
    return Typographies._internal(GoogleFonts.rajdhani(
      color: palette.color,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ));
  }

  factory Typographies.header(Palette palette) {
    return Typographies._internal(GoogleFonts.rajdhani(
      color: palette.color,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ));
  }
}