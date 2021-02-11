
import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/cartesian_graph_analyzer.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:cartesian_graph/pixel_location.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';

class InteractiveGraph extends StatefulWidget {
  final Function(Coordinates updatedLocation) moveCursor;
  final GraphCursor cursor;
  final List<String> inputEquations;
  final ScaleSettings scaleSettings;


  InteractiveGraph(this.inputEquations,this.scaleSettings,this.cursor, this.moveCursor);

  @override
  State<StatefulWidget> createState() => InteractiveGraphState();
}
class InteractiveGraphState extends State<InteractiveGraph>{
  static const double GRAPH_HEIGHT = 652;


  void _updateScale(){
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    widget.scaleSettings.addListener(_updateScale);
  }

  @override
  void didUpdateWidget(InteractiveGraph oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(oldWidget.scaleSettings != widget.scaleSettings) {
      oldWidget.scaleSettings.removeListener(_updateScale);
      widget.scaleSettings.addListener(_updateScale);
    }
  }

  @override
  void dispose(){
    widget.scaleSettings.removeListener(_updateScale);
    super.dispose();
  }

  Shadow _buildShadow(double min, double max){
    return Shadow(
        blurRadius: 5,
        offset: Offset(min, max),
        color: Colors.white
    );
  }

  @override
  Widget build(BuildContext context) {
    CartesianGraph graph = CartesianGraph(
      Bounds(this.widget.scaleSettings.xMin, this.widget.scaleSettings.xMax, this.widget.scaleSettings.yMin,this.widget.scaleSettings.yMax),
      equations: this.widget.inputEquations,
      cursorLocation: this.widget.cursor.location,
      cursorColor: this.widget.cursor.color,
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
                Text(
                ' X=${this.widget.cursor.location.x}   Y=${this.widget.cursor.location.y}',
                  style:TextStyle(fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      shadows: [
                        _buildShadow(-1.5,-1.5),
                        _buildShadow(1.5,-1.5),
                        _buildShadow(1.5,1.5),
                        _buildShadow(-1.5,1.5)
                      ])
                )
             ],
          ),
          onTapDown: (TapDownDetails details){
            double y = GRAPH_HEIGHT - (details.localPosition.dy * devicePixelRatio);
            double x = details.localPosition.dx * devicePixelRatio;
            Coordinates updatedLocation = analyzer.calculateCoordinates(PixelLocation(x.toInt(), y.toInt()));
            this.widget.moveCursor(updatedLocation);
          },
        )
    );
  }

}