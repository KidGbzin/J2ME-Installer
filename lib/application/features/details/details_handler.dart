import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:j2me_installer/application/core/repositories/storage_repository.dart';

import '../../core/entities/game_entity.dart';
import '../../core/entities/midlet_entity.dart';

import '../../core/enumerations/logger_enumeration.dart';
import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/progress_enumeration.dart';
import '../../core/enumerations/typographies_enumeration.dart';

import '../../core/repositories/database_repository.dart';

import '../../core/services/activity_service.dart';
import '../../widgets/button_widget.dart';

part '../details/components/about_section_component.dart';
part '../details/components/collection_section_component.dart';
part '../details/components/cover_component.dart';
part '../details/components/dialog_component.dart';
part '../details/components/play_button_component.dart';
part 'components/preview_section_component.dart';

part '../details/views/details_view.dart';

part '../details/details_controller.dart';

/// The screen responsible to show all the game's data.
/// Such cover arts, game description, and the .JAR files available to install.
class Details extends StatefulWidget {
  const Details(this.title, {super.key});

  final String title;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late _Controller controller;

  @override
  void initState() {
    controller = _Controller()..initialize(widget.title);

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? _) {
        if (value == Progress.loading) {
          return const SizedBox.shrink();
        }
        else if (value == Progress.error) {
          return const SizedBox.shrink();
        }
        else {
          return _Details(controller);
        }
      },
      valueListenable: controller.progress,
    );
  }
}