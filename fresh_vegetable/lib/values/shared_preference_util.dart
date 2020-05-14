import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  /// Returns all keys in the persistent storage.
  static Future<Set<String>> getKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }

  /// Reads a value of any type from persistent storage.
  static Future<dynamic> get(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a bool.
  static Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not an int.
  static Future<int> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a double.
  static Future<double> getDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  /// Reads a value from persistent storage, throwing an exception if it's not a String.
  static Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Reads a set of string values from persistent storage, throwing an exception if it's not a string set.
  static Future<List<String>> getStringList(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  /// Saves a boolean [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  /// Saves an integer [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  /// Saves a double [value] to persistent storage in the background.
  /// Android doesn't support storing doubles, so it will be stored as a float.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  /// Saves a string [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  /// Saves a list of strings [value] to persistent storage in the background.
  /// If [value] is null, this is equivalent to calling [remove()] on the [key].
  static Future<bool> setStringList(String key, List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  /// Removes an entry from persistent storage.
  static Future<bool> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  /// Clear all entry from persistent storage.
  static Future<bool> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool status = await prefs.clear();
    return status;
  }
}
