import 'package:flutter/cupertino.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';

class CalculatorDisplayController extends ChangeNotifier{
  String _inputLine='';
  List<DisplayHistory> _history = [];
  int _cursorIndex = 0;

  List<DisplayHistory> get history{
    return _history;
  }

  set history(List<DisplayHistory> history){
    this._history = history;
    notifyListeners();
  }

  String get inputLine{
    return _inputLine;
  }

  set inputLine(String text){
    this._inputLine = text;
    this._cursorIndex = text.length;
    notifyListeners();
  }

  int get cursorIndex{
    return _cursorIndex;
  }

  set cursorIndex(int cursorIndex){
    this._cursorIndex = cursorIndex;
    notifyListeners();
  }

  void input(String token){
    String startToken = this._inputLine.substring(0,_cursorIndex);
    String endToken = this._inputLine.substring(_cursorIndex);
    this._inputLine = startToken + token + endToken;
    this._cursorIndex += token.length;
    notifyListeners();
  }

  void delete(){
    if(_cursorIndex < this._inputLine.length) {
      String startToken = this._inputLine.substring(0, _cursorIndex);
      String endToken = this._inputLine.substring(_cursorIndex + 1);
      this._inputLine = startToken + endToken;
      notifyListeners();
    }
  }
}