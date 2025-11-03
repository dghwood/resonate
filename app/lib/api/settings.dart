import 'package:resonate/models/models.dart';
import 'package:resonate/services/database.dart';
import 'package:resonate/storage/settings.dart';

class SettingsApi {
  SettingsApi({required AbstractDatabaseService databaseService})
    : _database = SettingsDatabase(databaseService);

  final SettingsDatabase _database;

  Future<void> init() async {
    // Load them from the server?
    try {
      await _database.get(_settings);
    } on Exception catch (e) {
      // Hmm..
    }
  }

  final Settings _settings = Settings(id: 'settings');
  Settings get settings => _settings;
}
