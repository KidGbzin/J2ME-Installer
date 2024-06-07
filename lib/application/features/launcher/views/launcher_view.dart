part of '../launcher_handler.dart';

class _Launcher extends StatelessWidget {
  const _Launcher();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SizedBox.square(
          dimension: 30,
          child: _Loading()
        ),
      ),
    );
  }
}