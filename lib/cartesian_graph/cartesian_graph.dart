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
  final List<Coordinates> Function(double xPrecision,double yPrecision) coordinatesBuilder;

  CartesianGraph(this.bounds, {this.coordinates, this.cursorLocation, this.legendColor = Colors.blueGrey, this.lineColor = Colors.black, this.coordinatesBuilder}):
      assert(!(coordinates != null && coordinatesBuilder != null));

  Future<ui.Image> _makeImage(double containerWidth, double containerHeight){
    final c = Completer<ui.Image>();
    GraphDisplay display = createGraphDisplay(this.bounds,DisplaySize(containerWidth,containerHeight),density);
    display.displayAxes(legendColor);
    if(cursorLocation != null){
      display.displayCursor(cursorLocation);
    }

    List<Coordinates> coordinates = this.coordinates;
    if(coordinatesBuilder != null){
      coordinates = coordinatesBuilder(display.xPrecision,display.yPrecision);
    }
    coordinates ??= [];

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

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        return Container(
            child: FutureBuilder<ui.Image>(
              future: _makeImage(constraints.maxWidth * devicePixelRatio,constraints.maxHeight),
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
    );
  }

}