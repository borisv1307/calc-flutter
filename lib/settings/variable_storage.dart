import 'package:shared_preferences/shared_preferences.dart';

class VariableStorage {
  final Map variableMap;
  
  VariableStorage() : variableMap = Map<String, String>();

  VariableStorage.loadFromPrefs(SharedPreferences _prefs) : variableMap = Map<String, String>() {
    setVariable('A', _prefs.getString('A') ?? null);
    setVariable('B', _prefs.getString('B') ?? null);
    setVariable('C', _prefs.getString('C') ?? null);
    setVariable('D', _prefs.getString('D') ?? null);
    setVariable('E', _prefs.getString('E') ?? null);
    setVariable('F', _prefs.getString('F') ?? null);
    setVariable('G', _prefs.getString('G') ?? null);
  }

  void setVariable(String key, String value) {
    if (value?.length != 0) {
      variableMap[key] = value;
    }
  }

  String getVariable(String key){
    return variableMap[key] ?? '0';
  }

  void clearStorage() {
    clearVariables();
  }

  void clearVariables() {
    variableMap.clear();
  }
}




