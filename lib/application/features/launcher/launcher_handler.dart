import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:j2me_installer/application/core/enumerations/typographies_enumeration.dart';
import 'package:j2me_installer/application/widgets/error_widget.dart';
import 'package:provider/provider.dart';

import '../../core/enumerations/logger_enumeration.dart';
import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/progress_enumeration.dart';

import '../../core/exceptions/github_exceptions.dart';

import '../../core/interfaces/bucket_interface.dart';
import '../../core/interfaces/database_interface.dart';

part '../launcher/components/install_section_component.dart';
part '../launcher/components/loading_component.dart';
part '../launcher/components/welcome_section_component.dart';

part '../launcher/views/landing_view.dart';
part '../launcher/views/launcher_view.dart';

part '../launcher/launcher_controller.dart';

class Launcher extends StatefulWidget {
  const Launcher({super.key});

  @override
  State<Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  late final _Controller controller;
  late final IAndroid android;
  late final IDatabase database;

  @override
  void initState() {
    database = Provider.of<IDatabase>(
      context,
      listen: false,
    );
    controller = _Controller(
      database: database,
    )..initialize(context);
  
    super.initState();
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
        else if (progress == Progress.finished) {
          return _Landing(controller);
        }
        else {
          return ErrorView(controller.message);
        }
      },
      valueListenable: controller.progress,
    );
  }
}