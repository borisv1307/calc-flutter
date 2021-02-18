import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/cartesian_graph_analyzer.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:cartesian_graph/pixel_location.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';

class InteractiveGraph extends StatefulWidget {
  final GraphCursor cursor;
  final List<String> inputEquations;
  final ScaleSettings scaleSettings;
  final int chosenEquationIndex;

  InteractiveGraph(this.inputEquations, this.scaleSettings, this.cursor,
      this.chosenEquationIndex);

  @override
  State<StatefulWidget> createState() => InteractiveGraphState();
}

class InteractiveGraphState extends State<InteractiveGraph> {
  static const double GRAPH_HEIGHT = 652;
  GraphCursor displayCursor = GraphCursor();
  AdvancedCalculator calculator = AdvancedCalculator();

  double _roundToInterval(double coordinate, double interval) {
    return (coordinate / interval).round() * interval;
  }

  void _moveCursor() {
    setState(() {
      Coordinates updatedLocation = this.widget.cursor.location;
      if (this.widget.cursor.equation != null) {
        double y = calculator.calculateEquation(
            this.widget.cursor.equation, this.widget.cursor.location.x);
        updatedLocation = Coordinates(this.widget.cursor.location.x, y);
      }
      displayCursor.location = Coordinates(
          _roundToInterval(updatedLocation.x, this.widget.scaleSettings.step),
          _roundToInterval(updatedLocation.y, this.widget.scaleSettings.step));
      displayCursor.color = this.widget.cursor.color;
    });
  }

  @override
  void initState() {
    super.initState();
    this.displayCursor.location = this.widget.cursor.location;
    this.displayCursor.color = this.widget.cursor.color;

    this.widget.scaleSettings.addListener(_moveCursor);
    this.widget.cursor.addListener(_moveCursor);
  }

  @override
  void didUpdateWidget(InteractiveGraph oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.scaleSettings != widget.scaleSettings) {
      oldWidget.scaleSettings.removeListener(_moveCursor);
      widget.scaleSettings.addListener(_moveCursor);
    }

    if (oldWidget.cursor != widget.cursor) {
      oldWidget.cursor.removeListener(_moveCursor);
      widget.cursor.addListener(_moveCursor);
    }
  }

  @override
  void dispose() {
    this.widget.scaleSettings.removeListener(_moveCursor);
    this.widget.cursor.removeListener(_moveCursor);
    super.dispose();
  }

  Shadow _buildShadow(double min, double max) {
    return Shadow(blurRadius: 5, offset: Offset(min, max), color: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    CartesianGraph graph = CartesianGraph(
      Bounds(this.widget.scaleSettings.xMin, this.widget.scaleSettings.xMax,
          this.widget.scaleSettings.yMin, this.widget.scaleSettings.yMax),
      equations: this.widget.inputEquations,
      cursorLocation: displayCursor.location,
      cursorColor: displayCursor.color,
      chosenEquationIndex: this.widget.chosenEquationIndex,
    );
    CartesianGraphAnalyzer analyzer = CartesianGraphAnalyzer(graph);

    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: GRAPH_HEIGHT,
        ),
        child: GestureDetector(
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              graph,
              if(displayCursor.location != null)
                Text(
                    ' X=${displayCursor.location.x}   Y=${displayCursor.location.y}',
                    style: TextStyle(
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        shadows: [
                          _buildShadow(-1.5, -1.5),
                          _buildShadow(1.5, -1.5),
                          _buildShadow(1.5, 1.5),
                          _buildShadow(-1.5, 1.5)
                        ]))
            ],
          ),
          onTapDown: (TapDownDetails details) {
            double y =
                GRAPH_HEIGHT - (details.localPosition.dy * devicePixelRatio);
            double x = details.localPosition.dx * devicePixelRatio;
            this.widget.cursor.location = analyzer
                .calculateCoordinates(PixelLocation(x.toInt(), y.toInt()));
          },
        ));
  }
}
