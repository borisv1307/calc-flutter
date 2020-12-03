import 'package:flutter/cupertino.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class CalculatorDisplayController extends ChangeNotifier{
  List<InputItem> _input = [];
  List<DisplayHistory> _history = [];
  int _inputIndex = 0;
  int _historyIndex = 0;
  String _alert;

  List<DisplayHistory> get history{
    return _history;
  }

  set history(List<DisplayHistory> history){
    this._history = history;
    notifyListeners();
  }

  void clearHistory(){
    this._history = [];
    notifyListeners();
  }

  String get inputLine{
    return _input.map((e) => e.value).join();
  }

  List<InputItem> get inputItems{
    return _input;
  }

  int get cursorIndex{
    return _input.sublist(0,_inputIndex).map((e) => e.value).join().length;
  }

  set cursorIndex(int cursorIndex){
    String output = '';
    for(int i = 0; i<= _input.length && cursorIndex >= output.length;i++){
      if(i < _input.length) {
        output += _input[i].value.toString();
      }
      this._inputIndex = i;
    }
    notifyListeners();
  }

  void input(InputItem item){
    _input.insert(_inputIndex, item);
    this._inputIndex++;
    notifyListeners();
  }

  void delete(){
    if(_inputIndex < this._input.length) {
      _input.removeAt(_inputIndex);
      notifyListeners();
    }
  }

  void clearInput(){
    this._input = [];
    this._inputIndex = 0;
    this._historyIndex = 0;
    notifyListeners();
  }

  void browseBackwards(){
    if(_historyIndex < this._history.length){
      _historyIndex++;
      _updateInputFromHistory();
    }
  }

  void browseForwards(){
    if(_historyIndex > 1){
      _historyIndex--;
      _updateInputFromHistory();
    }
  }

  void pushAlert(String alert){
    this._alert = alert;
    notifyListeners();
  }

  String popAlert(){
    String alert = _alert;
    _alert = null;
    return alert;
  }

  void _updateInputFromHistory(){
    this._input = List.from(this._history[this._history.length - _historyIndex].input);
    this._inputIndex = this._input.length;
    notifyListeners();
  }
}