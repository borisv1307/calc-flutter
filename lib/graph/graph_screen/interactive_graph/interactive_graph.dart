
import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/cartesian_graph_analyzer.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:cartesian_graph/pixel_location.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';

class InteractiveGraph extends StatelessWidget{
  static const double GRAPH_HEIGHT = 652;
  final Function(Coordinates updatedLocation) moveCursor;
  final GraphCursor cursor;
  final CartesianGraph graph;
  final CartesianGraphAnalyzer analyzer;
  final TextStyle locationStyle = TextStyle(fontFamily: 'RobotoMono', fontWeight: FontWeight.bold, color: Colors.black, shadows: [
      Shadow(
        offset: Offset(-1.5, -1.5),
        color: Colors.white,
        blurRadius: 5,
      ),
      Shadow(
        offset: Offset(1.5, -1.5),
        color: Colors.white,
        blurRadius: 5,
      ),
      Shadow(
        offset: Offset(1.5, 1.5),
        color: Colors.white,
        blurRadius: 5,
      ),
      Shadow(
        blurRadius: 5,
        offset: Offset(-1.5, 1.5),
        color: Colors.white
      ),
    ]);

  InteractiveGraph._internal(this.graph,this.moveCursor, this.cursor, this.analyzer);

  factory InteractiveGraph(List<String> inputEquations,  Bounds bounds, GraphCursor cursor, Function(Coordinates updatedLocation) moveCursor,[CartesianGraphAnalyzer specifiedAnalyzer]){
    CartesianGraph graph = CartesianGraph(
      bounds,
      equations: inputEquations,
      cursorLocation: cursor.location,
      cursorColor: cursor.color,
    );
    CartesianGraphAnalyzer analyzer = specifiedAnalyzer ?? CartesianGraphAnalyzer(graph);
    return InteractiveGraph._internal(graph, moveCursor, cursor, analyzer);
  }

  @override
  Widget build(BuildContext context) {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: GRAPH_HEIGHT,
        ),
        child: GestureDetector(
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
               this.graph,
                Text(
                ' X=${cursor.location.x}   Y=${cursor.location.y}',
                  style:locationStyle
                )
             ],
          ),
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