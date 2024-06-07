import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:j2me_installer/application/core/services/android_service.dart';

import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/progress_enumeration.dart';

import '../../core/repositories/database_repository.dart';

part '../launcher/components/loading_component.dart';

part '../launcher/views/launcher_view.dart';

part '../launcher/launcher_controller.dart';

class Launcher extends StatefulWidget {
  const Launcher({super.key});

  @override
  State<Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  late final _Controller controller;

  @override
  void initState() {
    super.initState();

    controller = _Controller()..initialize(context);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, Progress progress, Widget? _) {
        if (progress == Progress.loading) {
          return const _Launcher();
        }
        else {
          return const SizedBox.shrink();
        }
      },
      valueListenable: controller.progress,
    );
  }
}