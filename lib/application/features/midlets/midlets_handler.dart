import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/entities/midlet_entity.dart';

import '../../core/enumerations/logger_enumeration.dart';
import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/progress_enumeration.dart';
import '../../core/enumerations/typographies_enumeration.dart';

import '../../core/repositories/database_repository.dart';
import '../../core/repositories/storage_repository.dart';

import '../../widgets/button_widget.dart';

part 'components/icon_component.dart';
part 'components/tile_component.dart';

part 'views/midlets_view.dart';

part 'midlets_controller.dart';

class MIDlets extends StatefulWidget {
  const MIDlets(this.title, {super.key});

  final String title;

  @override
  State<MIDlets> createState() => _MIDletsState();
}

class _MIDletsState extends State<MIDlets> {
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
          return _MIDlets(controller);
        }
      },
      valueListenable: controller.progress,
    );
  }
}