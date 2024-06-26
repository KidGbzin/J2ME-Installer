part of '../launcher_handler.dart';

class _Error extends StatelessWidget {
  const _Error(this.controller);

  final _Controller controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Text(
          controller.message,
          style: Typographies.body(Palette.elements).style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}