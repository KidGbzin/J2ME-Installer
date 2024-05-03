import 'package:flutter/material.dart';

import '../core/enumerations/palette_enumeration.dart';

/// The global appication's button.
/// 
/// The parameter [icon] is the material icon from the Flutter SDK. It's of the type [IconData]. \
/// The parameter [onTap] is an function to be executed when [Button] is tapped. It's of the type [Function].
class Button extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  
  const Button({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.divider.color,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.5),
          color: Palette.foreground.color,
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