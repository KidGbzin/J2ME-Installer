import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/contracts/controller_contract.dart';

import '../../core/entities/game_entity.dart';

import '../../core/enumerations/logger_enumeration.dart';
import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/states_enumeration.dart';
import '../../core/enumerations/typographies_enumeration.dart';

import '../../core/repositories/cache_repository.dart';
import '../../core/repositories/games_repository.dart';

import '../../core/services/github_service.dart';

import '../../utilities/button_component.dart';
import '../../utilities/tags_component.dart';

part '../details/components/cover_component.dart';
part '../details/components/divider_component.dart';

part '../details/views/details_view.dart';

part '../details/details_controller.dart';

/// The screen responsible to show all the game's data.
/// Such cover arts, game description, and the .JAR files available to install.
/// 
/// The parameter [title] is self-explanatory, just the game's title. It is of type [String].
class Details extends StatefulWidget {
  final String title;

  const Details(this.title, {super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late _Controller _controller;

  @override
  void initState() {
    _controller = _Controller(
      player: AudioPlayer(),
      title: widget.title,
    );
    _controller.initialize();
    
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Notifier(
      notifier: _controller,
      child: _handler(),
    );
  }

  Widget _handler() {
    if (_controller.state == States.loading) return const SizedBox();
    if (_controller.state == States.error) return const SizedBox();
    if (_controller.state == States.finished) return _Details(_controller.game);
    throw Exception();
  }
}