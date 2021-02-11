import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/material.dart';

class GraphCursor extends ChangeNotifier{
  Coordinates _location = Coordinates(0, 0);
  double _step = 1;
  Color _color = Colors.blue;

  get location{
    return _location;
  }

  set location(Coordinates location){
    this._location = location;
    notifyListeners();
  }

  get color{
    return _color;
  }

  set color(Color color){
    this._color = color;
    notifyListeners();
  }
}