import 'package:flutter/material.dart';

/// An enumeration to [print] colored logs on the console.
/// 
/// Instead of using just one [print] function, use [Logger] for better code analysis.
enum Logger {
  /// An [error] log.
  /// 
  /// Used to [print] unhandled [Exception]s that breaks the application.
  error('31', '⛔'),

  /// An [success] log.
  /// 
  /// Used to [print] sucessfull requests.
  success('32', '✅',),

  /// An [warning] log.
  /// 
  /// Used to [print] alerts that does not break the application such as "not found" actions.
  warning('33', '📣');

  const Logger(this.code, this.emoji);

  /// The color code, each code is a different color.
  /// 
  /// Code 30: Black; \
  /// Code 31: Red; \
  /// Code 32: Green; \
  /// Code 33: Yellow; \
  /// Code 34: Blue; \
  /// Code 35: Purple; \
  /// Code 36: Cyan; \
  /// Code 37: White.
  /// 
  /// Any other code provided will not affect the color of the console's text, which is blue by default.
  final String code;

  /// The leading emoji showed in the console.
  final String emoji;

  /// Print function on the console with a colored text
  /// 
  /// The written log is led by an [emoji] and its color is based on the [Logger] enumeration value provided.
  void log(String text) => debugPrint('\x1b[${code}m$emoji $text\x1B[0m');
}