import 'package:shared_preferences/shared_preferences.dart';

/// Kapselt die lokale Speicherung auf dem Gerät.
///
/// Alles bleibt auf dem Handy – kein Login, kein Server.
class StorageService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  static const String _countPrefix = 'count_';
  static const String _vibrationKey = 'vibration_enabled';

  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  int loadCount(String id) => _prefs.getInt('$_countPrefix$id') ?? 0;

  Future<void> saveCount(String id, int value) =>
      _prefs.setInt('$_countPrefix$id', value);

  bool loadVibration() => _prefs.getBool(_vibrationKey) ?? true;

  Future<void> saveVibration(bool enabled) =>
      _prefs.setBool(_vibrationKey, enabled);
}
