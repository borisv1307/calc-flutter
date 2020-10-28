
class VariableStorage {

  Map variableMap;
  
  VariableStorage(){
    variableMap = new Map();
  }

  void addVariable(String key, String value) {
    variableMap[key] = value;
  }

  String fetchVariable(String key){
    return variableMap[key];
  }
}




