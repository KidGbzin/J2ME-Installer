import 'package:flutter/material.dart';

import '../core/enumerations/palette_enumeration.dart';

/// The global appication's button.
/// 
/// This button is used everywhere in the application.
class Button extends StatelessWidget {
  const Button({
    required this.icon,
    required this.onTap,
    super.key,
  });

  /// A material icon from the Flutter SDK.
  final IconData icon;

  /// An function to be executed when [Button] is tapped.
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.5),
          color: Palette.transparent.color,
        ),
        height: 37.5,
        width: 37.5,
        child: Icon(
          icon,
          color: Palette.elements.color,
        ),
      ),
    );
  }
}