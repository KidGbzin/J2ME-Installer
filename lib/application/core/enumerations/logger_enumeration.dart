import 'package:flutter/material.dart';

/// An enumeration to [print] colored logs on the console.
///
/// Instead of using a single [print] function, use [Logger] for better code analysis and readability.
enum Logger {
  /// An [error] log.
  ///
  /// Used to [print] unhandled [Exception]s that break the application.
  error("31", "⛔"),

  /// An [information] log.
  ///
  /// Used to [print] general information that doesn't affect application functionality.
  information("00", "📣"),

  /// A [success] log.
  ///
  /// Used to [print] successful requests.
  success("32", "✅"),

  /// A [warning] log.
  ///
  /// Used to [print] alerts that do not break the application, such as "not found" actions.
  warning("33", "📢");

  /// Creates a [Logger] with the given [code] and [emoji].
  const Logger(this.code, this.emoji);

  /// The color code, each code represents a different color.
  ///
  /// - Code 30: Black;
  /// - Code 31: Red;
  /// - Code 32: Green;
  /// - Code 33: Yellow;
  /// - Code 34: Blue;
  /// - Code 35: Purple;
  /// - Code 36: Cyan;
  /// - Code 37: White.
  ///
  /// Any other code will not affect the console text color, which defaults to blue.
  final String code;

  /// The leading emoji displayed in the console.
  final String emoji;

  /// Prints a log message to the console with colored text.
  ///
  /// The log message is prefixed with an [emoji] and its color is based on the [Logger] enumeration value.
  void log(String text) => debugPrint("\x1b[${code}m$emoji $text\x1B[0m");
}