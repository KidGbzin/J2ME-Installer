import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../../core/contracts/controller_contract.dart';

import '../../core/entities/game_entity.dart';

import '../../core/enumerations/palette_enumeration.dart';
import '../../core/enumerations/states_enumeration.dart';
import '../../core/enumerations/typographies_enumeration.dart';

import '../../core/repositories/android_repository.dart';
import '../../core/repositories/games_repository.dart';

import '../../core/services/github_service.dart';

import '../../utilities/button_component.dart';
import '../../utilities/tags_component.dart';

part '../home/components/cover_component.dart';
part '../home/components/grid_view_component.dart';
part '../home/components/list_view_component.dart';
part '../home/components/list_tile_component.dart';

part '../home/views/error_view.dart';
part '../home/views/home_view.dart';
part '../home/views/loading_view.dart';

part '../home/home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late _Controller _controller;

  @override
  void initState() {
    _controller = _Controller();
    _controller.initialize().whenComplete(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _Notifier(
      notifier: _controller,
      child: _handler(),
    );
  }

  Widget _handler() {
    if (_controller.state == States.loading) return const _Loading();
    if (_controller.state == States.error) return const _Error();
    if (_controller.state == States.finished) return const _Home();
    throw Exception();
  }
}