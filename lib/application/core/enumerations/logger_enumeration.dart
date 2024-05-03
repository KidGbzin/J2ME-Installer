import 'package:flutter/material.dart';

/// An enumeration for print colored logs on the console.
/// 
/// Instead of using just one [print] function, use [Logger] for better code analysis.
enum Logger {
  error('31', '⛔'),
  success('32', '✅'),
  warning('33', '📣');

  final String code;
  final String emoji;

  const Logger(
    this.code,
    this.emoji,
  );

  /// Print function with a colored text, using the [Logger] enumeration value.
  /// 
  /// The parameter [text] is the value to be printed on the console. It's of the type [String].
  void log(String text) => debugPrint('\x1b[${code}m$emoji $text\x1B[0m');
}