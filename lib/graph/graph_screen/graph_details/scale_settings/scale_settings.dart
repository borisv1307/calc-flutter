import 'package:flutter/cupertino.dart';

class ScaleSettings extends ChangeNotifier{
  int _xMin;
  int _xMax;
  int _yMin;
  int _yMax;
  double _step;

  ScaleSettings([this._xMin=-10,this._xMax=10,this._yMin=-10,this._yMax=10,this._step=1]);

  get xMin{
    return _xMin;
  }

  set xMin(int xMin){
    this._xMin = xMin;
    notifyListeners();
  }

  get xMax{
    return _xMax;
  }

  set xMax(int xMax){
    this._xMax = xMax;
    notifyListeners();
  }

  get yMin{
    return _yMin;
  }

  set yMin(int yMin){
    this._yMin = yMin;
    notifyListeners();
  }

  get yMax{
    return _yMax;
  }

  set yMax(int yMax){
    this._yMax = yMax;
    notifyListeners();
  }
  
  get step{
    return _step;
  }

  set step(double step){
    this._step = step;
    notifyListeners();
  }
}