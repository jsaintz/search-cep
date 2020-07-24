import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> saveCepPreference(String cep) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(cep, cep);
  }

  static Future<void> getCepPreference(String cep) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(cep);
  }
}
