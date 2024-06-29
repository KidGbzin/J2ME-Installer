part of '../launcher_handler.dart';

class _Landing extends StatelessWidget {

  const _Landing(this.controller);

  final _Controller controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget> [
          _Welcome(controller),
          _Install(controller),
        ],
      ),
    );
  }
}