import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../../core/entities/jar_entity.dart';

import '../../core/enumerations/folder_enumeration.dart';
import '../../core/enumerations/logger_enumeration.dart';
import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/progress_enumeration.dart';
import '../../core/enumerations/typographies_enumeration.dart';

import '../../core/repositories/android_repository.dart';
import '../../core/repositories/database_repository.dart';

import '../../core/services/github_service.dart';
import '../../widgets/button_widget.dart';

part '../jars/components/icon_component.dart';
part '../jars/components/tile_component.dart';

part '../jars/views/jars_view.dart';

part '../jars/jars_controller.dart';

class JARs extends StatefulWidget {
  const JARs(this.title, {super.key});

  final String title;

  @override
  State<JARs> createState() => _JARsState();
}

class _JARsState extends State<JARs> {
  late _Controller controller;

  @override
  void initState() {
    controller = _Controller()..initialize(widget.title);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? _) {
        if (value == Progress.loading) {
          return const SizedBox();
        }
        else if (value == Progress.error) {
          return const SizedBox();
        }
        else {
          return _JARs(controller);
        }
      },
      valueListenable: controller.progress,
    );
  }
}