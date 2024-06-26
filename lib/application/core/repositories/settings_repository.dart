import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../entities/game_entity.dart';

import '../interfaces/settings_interface.dart';

class Settings implements ISettings {

  /// The local configuration [Box].
  /// 
  /// All cached settings will be stored here. This [Box] includes:
  /// 
  /// - `lastCheck`: When the API file was last checked;
  /// - `lastUpdated`: When the API bucket was last updated.
  late final Box<Object> _box;

  @override
  void put(String key, Object object) => _box.put(key, object);
  
  @override
  void close() => _box.close();
  
  @override
  void open() {
    _box = Hive.box<Game>(
      maxSizeMiB: 1,
      name: 'SETTINGS',
    );
  }

  @override
  void clear() => _box.clear();

  bool hasChecked() {
    final DateTime now = DateTime.now();
    final DateTime lastCheck = (_box.get("lastCheck") as DateTime?) ?? DateTime(1970);
    _box.put('lastCheck', now);
    return DateUtils.isSameDay(now, lastCheck);
  }
}