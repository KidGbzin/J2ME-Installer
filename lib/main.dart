import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../application.dart';

import '../application/core/interfaces/bucket_interface.dart';
import '../application/core/interfaces/database_interface.dart';

import '../application/core/repositories/bucket_repository.dart';
import '../application/core/repositories/database_repository.dart';

import '../application/core/services/android_service.dart';
import '../application/core/services/github_service.dart';

void main() {
  runApp(MultiProvider(
    providers: <SingleChildWidget> [
      Provider<IBucket>.value(
        value: Bucket(
          android: Android(),
          gitHub: GitHub(),
        ),
      ),
      Provider<IDatabase>.value(
        value: Database(),
      ),
    ],
    child: const Application(),
  ));
}