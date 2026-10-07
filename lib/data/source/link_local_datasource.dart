import 'package:shared_preferences/shared_preferences.dart';

class LinkLocalDataSource {
  LinkLocalDataSource(this._preferences);

  final SharedPreferences _preferences;

  static const String _urlKey = 'saved_url';

  Future<void> saveUrl(String url) async {
    await _preferences.setString(_urlKey, url);
  }

  String? getUrl() {
    return _preferences.getString(_urlKey);
  }

  Future<void> deleteUrl() async {
    await _preferences.remove(_urlKey);
  }
}