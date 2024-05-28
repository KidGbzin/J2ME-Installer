import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:j2me_installer/application/core/repositories/storage_repository.dart';

import '../../core/entities/game_entity.dart';

import '../../core/enumerations/logger_enumeration.dart';
import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/progress_enumeration.dart';
import '../../core/enumerations/typographies_enumeration.dart';
import '../../core/enumerations/view_type_enumeration.dart';

import '../../core/repositories/database_repository.dart';

import '../../core/services/android_service.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/tags_widget.dart';

part '../home/components/cover_component.dart';
part '../home/components/grid_view_component.dart';
part '../home/components/list_view_component.dart';
part '../home/components/list_tile_component.dart';
part '../home/components/toggle_button_component.dart';

part '../home/views/error_view.dart';
part '../home/views/loading_view.dart';
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
    controller = _Controller();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? _) {
        if (value == Progress.loading) {
          return const _Loading();
        }
        else if (value == Progress.error) {
          return const _Error();
        }
        else {
          return _View(controller);
        }
      },
      valueListenable: controller.progressState,
    );
  }
}