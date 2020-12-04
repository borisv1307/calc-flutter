import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class GraphDisplayController extends ChangeNotifier{
  List<List<InputItem>> _inputs = [[]];  // input for each text field
  int currentField = 0;                  // index of active text field

  String getInput(int index){
    return _inputs[index].map((e) => e.value).join();
  }

  List<InputItem> getInputItems(int index){
    return _inputs[index];
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
}
