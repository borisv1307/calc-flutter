import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class FunctionDisplayController extends ChangeNotifier{
  List<List<InputItem>> _inputs = [[]];  // input for each text field
  int currentField = 0;                  // index of active text field
  VariableStorage storage;

  FunctionDisplayController(this.storage);

  List<List<InputItem>> get inputs {
    return _inputs;
  }

  List<InputItem> getInputItems(int index){
    return _inputs[index];
  }

  String getInput(int index){
    return _inputs[index].map((e) => e.value).join();
  }

  void addField() {
    _inputs.add([]);
  }

  void removeField(int index) {
    if(index < _inputs.length) {
      _inputs.removeAt(index);
    }
  }

  void input(InputItem item){
    _inputs[currentField].add(item);
    notifyListeners();
  }

  void delete(){
    if(_inputs[currentField].length > 0) {
      _inputs[currentField].removeLast();
      notifyListeners();
    }
  }

  void clearInput(){
    this._inputs[currentField] = [];
    notifyListeners();
  }

  // return functions as strings with variables translated
  List<String> translateInputs() {
    List<String> results = [];
    for (List<InputItem> input in this._inputs) {
      String inputString = '';
      for(InputItem item in input) {
        if (item.variable){
          inputString += storage.fetchVariable(item.value);
        } else{
          inputString += item.value;
        }
      }
      results.add(inputString);
      }
    return results;
  }
}
