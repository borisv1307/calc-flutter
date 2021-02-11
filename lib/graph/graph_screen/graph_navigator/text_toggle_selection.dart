import 'package:flutter/cupertino.dart';

class TextToggleSelection extends ChangeNotifier{
  String _selected;

  TextToggleSelection(this._selected);

  set selected(String selected){
    this._selected = selected;
    notifyListeners();
  }

  get selected{
    return this._selected;
  }
}