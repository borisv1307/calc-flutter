import 'package:cartesian_graph/segment_bounds.dart';
import 'package:flutter/material.dart';

class GraphLine{
  Color color = Colors.black;
  String equation;
  SegmentBounds segmentBounds = SegmentBounds();

  GraphLine(this.equation);
}