import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class AppLoggingEntry {
  AppLoggingEntry({
    required this.level,
    required this.message,
    required this.loggerName,
  }) {
    timestamp = DateTime.now();
  }
  final String level;
  final String message;
  final String loggerName;
  late final DateTime timestamp;

  @override
  String toString() {
    return '$timestamp $level: $loggerName: $message';
  }
}

class AppLogger {
  AppLogger();

  void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(onListen);
  }

  void onListen(LogRecord record) {
    var entry = AppLoggingEntry(
      level: record.level.name,
      message: record.message,
      loggerName: record.loggerName,
    );
    add(entry);
    if (!kReleaseMode) {
      print(entry);
    }
  }

  final List<AppLoggingEntry> _entries = [];

  void add(AppLoggingEntry entry) {
    if (_entries.length > 1000) {
      _entries.removeAt(0);
    }
    _entries.add(entry);
  }

  List<String> get levels => ['ALL', 'INFO', 'WARNING'];

  void clear() {
    _entries.clear();
  }

  List<AppLoggingEntry> get entries => _entries;

  static AppLogger get instance => _appLogger;
}

final AppLogger _appLogger = AppLogger();
