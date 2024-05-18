import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../../core/entities/game_entity.dart';
import '../../core/entities/jar_entity.dart';

import '../../core/enumerations/logger_enumeration.dart';
import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/progress_enumeration.dart';
import '../../core/enumerations/typographies_enumeration.dart';

import '../../core/repositories/android_repository.dart';
import '../../core/repositories/games_repository.dart';

import '../../core/services/github_service.dart';

import '../../utilities/button_widget.dart';
import '../../utilities/tags_widget.dart';

part '../details/components/cover_component.dart';
part '../details/components/divider_component.dart';
part '../details/components/play_button_component.dart';

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
    controller = _Controller(widget.title)..initialize();

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