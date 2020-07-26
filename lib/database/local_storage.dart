import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> saveCepPreference(String cep) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(cep, cep);
  }


  static Future loadCep(String cep) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs..getStringList(cep);
  }
}
