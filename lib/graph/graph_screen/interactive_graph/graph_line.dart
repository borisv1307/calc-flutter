import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_line_bounds.dart';

class GraphLine extends ChangeNotifier{
  Color _color = Colors.black;
  String _equation;
  GraphLineBounds _segmentBounds = GraphLineBounds();

  GraphLine(this._equation){
    _segmentBounds.addListener(notifyListeners);
  }

  get color{
    return _color;
  }

  set color(Color color){
    this._color = color;
    notifyListeners();
  }

  get equation{
    return _equation;
  }

  set equation(String equation){
    this._equation = equation;
    notifyListeners();
  }

  get segmentBounds{
    return _segmentBounds;
  }

  set segmentBounds(GraphLineBounds segmentBounds){
    _segmentBounds.removeListener(notifyListeners);
    segmentBounds.addListener(notifyListeners);
    this._segmentBounds = segmentBounds;
    notifyListeners();
  }
}