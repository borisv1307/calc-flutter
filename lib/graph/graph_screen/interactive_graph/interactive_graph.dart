
import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/cartesian_graph_analyzer.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:cartesian_graph/pixel_location.dart';
import 'package:flutter/material.dart';

class InteractiveGraph extends StatelessWidget{
  static const double GRAPH_HEIGHT = 652;
  final Function(Coordinates updatedLocation) moveCursor;
  final CartesianGraph graph;
  final CartesianGraphAnalyzer analyzer;

  InteractiveGraph._internal(this.graph,this.moveCursor, this.analyzer);

  factory InteractiveGraph(List<String> inputEquations,  Bounds bounds, Coordinates cursorLocation, Function(Coordinates updatedLocation) moveCursor,[CartesianGraphAnalyzer specifiedAnalyzer]){
    CartesianGraph graph = CartesianGraph(
      bounds,
      equations: inputEquations,
      cursorLocation: cursorLocation,
    );
    CartesianGraphAnalyzer analyzer = specifiedAnalyzer ?? CartesianGraphAnalyzer(graph);
    return InteractiveGraph._internal(graph, moveCursor, analyzer);
  }

  @override
  Widget build(BuildContext context) {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: GRAPH_HEIGHT,
        ),
        child: GestureDetector(
          child: this.graph,
          onTapDown: (TapDownDetails details){
            double y = GRAPH_HEIGHT - (details.localPosition.dy * devicePixelRatio);
            double x = details.localPosition.dx * devicePixelRatio;
            Coordinates updatedLocation = analyzer.calculateCoordinates(PixelLocation(x.toInt(), y.toInt()));
            this.moveCursor(updatedLocation);
          },
        )
    );
  }

}