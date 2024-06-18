import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:j2me_installer/application/core/enumerations/typographies_enumeration.dart';
import 'package:j2me_installer/application/widgets/tags_widget.dart';

import '../../core/entities/game_entity.dart';

import '../../core/enumerations/logger_enumeration.dart';
import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/progress_enumeration.dart';

import '../../core/repositories/database_repository.dart';

import '../../core/repositories/storage_repository.dart';

part '../home/components/cover_component.dart';
part '../home/components/grade_component.dart';
part '../home/components/lister_component.dart';
part '../home/components/list_tile_component.dart';

part '../home/views/home_view.dart';

part '../home/home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late _Controller controller;

  @override
  void initState() {
    controller = _Controller()..initialize();

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
          return const SizedBox.shrink();
        }
        else if (progress == Progress.finished) {
          return _Home(controller);
        }
        else {
          return const SizedBox.shrink();
        }
      },
      valueListenable: controller.progress,
    );
  }
}