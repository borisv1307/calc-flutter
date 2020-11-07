import 'package:flutter/cupertino.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';

class CalculatorDisplayController extends ChangeNotifier{
  String _inputLine='';
  List<DisplayHistory> _history = [];

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
    notifyListeners();
  }
}