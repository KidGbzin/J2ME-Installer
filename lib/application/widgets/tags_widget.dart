import 'package:flutter/material.dart';

import '../core/enumerations/palette_enumeration.dart';
import '../core/enumerations/typographies_enumeration.dart';

/// Show the tags of a game.
class Tags extends StatelessWidget {

  const Tags(this.tags, {super.key});

  /// A list of game tags.
  /// 
  /// Used to show a tag label for each game tag.
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 5,
      runSpacing: 5,
      children: _getTags(),
    );
  }

  /// Transform the [tags] list into a list of [_tag] widget. 
  List<Widget> _getTags() {
    final List<Widget> temporary = <Widget> [];
    for (String index in tags) {
      final Widget tag = _tag(index);
      temporary.add(tag);
    }
    return temporary;
  }

  /// Build a label [Widget] using the tag name. 
  Widget _tag(String tag) {
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Palette.primary.color.withOpacity(0.33),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Palette.primary.color.withOpacity(0.33),
        ),
        height: 27.5,
        padding: const EdgeInsets.fromLTRB(7.5, 0, 7.5, 0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            tag,
            style: Typographies.a(Palette.elements).style,
          ),
        ),
      ),
    );
  }
}