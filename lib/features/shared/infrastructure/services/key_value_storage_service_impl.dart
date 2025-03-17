import 'package:shared_preferences/shared_preferences.dart';
import 'key_value_storage_service.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService{

  Future<SharedPreferences> getSharedPref() async {
    return await SharedPreferences.getInstance();
  }
  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPref();
    switch(T) {
      case int:
        return prefs.getInt(key) as T?;

      case String:
        return prefs.getString(key)  as T?;

      default:
      throw UnimplementedError("Set no implementado para el tipo ${T.runtimeType}");
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPref();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPref();

    if (T == int) {
      prefs.setInt(key, value as int);
    }else if (T == String){
      prefs.setString(key, value as String);
    }else {
      throw UnimplementedError("Set no implementado para el tipo ${T.toString()}");
    }
  }
}