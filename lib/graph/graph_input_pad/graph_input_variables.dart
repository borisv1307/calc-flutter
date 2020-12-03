
class FunctionVariableStorage {

  Map variableMap;

  variableStorage(){
    variableMap = new Map();
  }

  void addVariable(String key, String value) {
    variableMap[key] = value;
  }

  String fetchVariable(String key){
    return variableMap[key] ?? '0';
  }
}




