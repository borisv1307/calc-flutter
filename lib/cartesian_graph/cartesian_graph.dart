import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/cartesian_graph/bounds.dart';
import 'package:open_calc/cartesian_graph/coordinates.dart';
import 'package:open_calc/cartesian_graph/display/display_size.dart';
import 'dart:ui' as ui;
import 'dart:async';

import 'display/graph_display.dart';

class CartesianGraph extends StatelessWidget{
  final List<Coordinates> coordinates;
  final Coordinates cursorLocation;
  final int density = 4;
  final Color legendColor;
  final Color lineColor;
  final Bounds bounds;

  CartesianGraph(this.bounds, {List<Coordinates> coordinates, this.cursorLocation, this.legendColor = Colors.blueGrey, this.lineColor = Colors.black, List<Coordinates> Function(double xPrecision,double yPrecision) coordinateBuilder}):
      this.coordinates = coordinates ?? [];

  Future<ui.Image> _makeImage(double containerWidth, double containerHeight){
    int width = 270;
    int height = 162;
    final c = Completer<ui.Image>();
    GraphDisplay display = createGraphDisplay(this.bounds,DisplaySize(containerWidth,652),density);
    display.displayLegend(legendColor);
    if(cursorLocation != null){
      display.displayCursor(cursorLocation);
    }

    for(int i = 0; i< coordinates.length-1;i++){
      display.plotSegment(coordinates[i],coordinates[i+1], lineColor);
    }

    display.render(c.complete);

    return c.future;
  }

  GraphDisplay createGraphDisplay(Bounds bounds, DisplaySize displaySize, int density){
    return GraphDisplay.bounds(bounds,displaySize,density);
  }


  @override
  Widget build(BuildContext context) {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    double width = MediaQuery.of(context).size.width * devicePixelRatio;
    double height = MediaQuery.of(context).size.height * devicePixelRatio;

    return Container(
        child: FutureBuilder<ui.Image>(
          future: _makeImage(width,height),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RawImage(
                image: snapshot.data,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }

}