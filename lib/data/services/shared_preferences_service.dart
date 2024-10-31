// ignore_for_file: constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

class _Keys {
  static const ONBOARDING = 'ONBOARDING';
  static const SHOWCOUNT = 'SHOW_COUNT';
  static const COUNTGENERATION = 'COUNT_GENERATION';
  static const DATEUPDATECOUNTGENERATION = 'DATE_UPDATE_COUNT_GENERATION';
}

class SharedPreferencesService {
  //ONBOARDING
  static Future<bool> switchStatusShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_Keys.ONBOARDING, true);
  }

  static Future<bool> getStatusShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_Keys.ONBOARDING) ?? false;
  }

  //SHOW COUNT
  static Future<bool> switchStatusShowCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_Keys.SHOWCOUNT, true);
  }
  static Future<bool> getStatusShowCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_Keys.SHOWCOUNT) ?? false;
  }
  //COUNT GENERATION
  static Future<bool> addCountGeneration() async {
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_Keys.COUNTGENERATION) ?? 0) + 1;
    return prefs.setInt(_Keys.COUNTGENERATION, count);
  }
  static Future<int> getCountGeneration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_Keys.COUNTGENERATION) ?? 0;
  }
  static Future<bool> clearCountGeneration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_Keys.COUNTGENERATION);
  }
  //DATE UPDATE COUNT GENERATION
  static Future<bool> setDateUpdateCountGeneration() async {
    final prefs = await SharedPreferences.getInstance();
    final time = DateTime.now().millisecondsSinceEpoch;
    return prefs.setInt(_Keys.DATEUPDATECOUNTGENERATION, time);
  }
  static Future<DateTime?> getDateUpdateCountGeneration() async {
    final prefs = await SharedPreferences.getInstance();
    final time = prefs.getInt(_Keys.DATEUPDATECOUNTGENERATION);
    if (time == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(time);
  }
  static Future<bool> clearDateUpdateCountGeneration() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_Keys.DATEUPDATECOUNTGENERATION);
  }
}
