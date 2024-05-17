part of '../home_handler.dart';

/// A button to toggle the view between [_ListView] and [_GridView].
class _ToggleButton extends StatelessWidget {

  const _ToggleButton({
    required this.listenable,
    required this.onTap,
  });

  /// The value to the button listen, it's a [ViewType].
  final ValueNotifier<ViewType> listenable;

  /// The function to be triggered when the button is tapped.
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, ViewType view, Widget? _) {
        if (view == ViewType.listView) {
          return Button(
            icon: Icons.list_rounded,
            onTap: onTap,
          );
        }
        else {
          return Button(
            icon: Icons.grid_3x3_rounded,
            onTap: onTap,
          );
        }
      },
      valueListenable: listenable,
    );
  }
}