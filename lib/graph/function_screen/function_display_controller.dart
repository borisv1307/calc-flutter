import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class FunctionDisplayController extends ChangeNotifier{
  List<List<InputItem>> _inputs = [[]];  // input for each text field
  int currentField = 0;                  // index of active text field

  List<List<InputItem>> get inputs {
    return _inputs;
  }

  List<InputItem> getInputItems(int index){
    return _inputs[index];
  }

  String getDisplayText(int index){
    return _inputs[index].map((e) => e.display).join();
  }

  void addField() {
    _inputs.add([]);
    notifyListeners();
  }

  void removeField(int index) {
    if(index < _inputs.length) {
      _inputs.removeAt(index);
    }
    notifyListeners();
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

  void load(List<List<InputItem>> functions) {
    _inputs = [];
    for (List<InputItem> func in functions) {
      List<InputItem> newFunction = [];
      for (InputItem item in func) {
        newFunction.add(item);
      }
      _inputs.add(newFunction);
    }
    if (_inputs.length == 0) {
      _inputs.add([]);
    }
  }
}
