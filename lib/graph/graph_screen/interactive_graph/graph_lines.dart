import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_line.dart';

class GraphLines extends ChangeNotifier with ListMixin<GraphLine>{
  final List<GraphLine> _lines = [];

  GraphLines([List<GraphLine> lines = const []]): length = lines.length {
    this._lines.addAll(lines);
    lines.forEach((line) => line.addListener(notifyListeners));
  }

  @override
  void add(GraphLine graphLine) {
    graphLine.addListener(notifyListeners);
    _lines.add(graphLine);
    length++;
    notifyListeners();
  }

  @override
  bool remove(Object graphLine) {
    bool removed = _lines.remove(graphLine);
    if(removed) {
      (graphLine as GraphLine).removeListener(notifyListeners);
      notifyListeners();
      length--;
    }
    return removed;
  }

  GraphLine operator [] (int index) => _lines[index];

  @override
  int length = 0;

  @override
  void operator []=(int index, GraphLine value) {
    _lines[index].removeListener(notifyListeners);
    value.addListener(notifyListeners);
   _lines[index] = value;
   notifyListeners();
  }
}