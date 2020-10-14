import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_calc/cartesian_graph/bounds.dart';
import 'package:open_calc/cartesian_graph/coordinates.dart';
import 'package:open_calc/cartesian_graph/display/display_size.dart';
import 'package:open_calc/cartesian_graph/display/pixel_map.dart';

class GraphDisplay{
  final int density;
  final int _xOffset;
  final int _yOffset;
  PixelMap pixelMap;
  final double xPrecision;
  final double yPrecision;

  GraphDisplay._internal(this._xOffset,this._yOffset,this.pixelMap, this.density, this.xPrecision, this.yPrecision);

  factory GraphDisplay.bounds(Bounds bounds, DisplaySize displaySize, int density){
        int minXPixels = _calculatePixels(bounds.xMin,bounds.xMax,density);
        int minYPixels = _calculatePixels(bounds.yMin,bounds.yMax,density);

        double xPrecision = minXPixels/(displaySize.width-density);
        double yPrecision = minYPixels/(displaySize.height-density);

        PixelMap pixelMap = PixelMap(displaySize.width.toInt(),displaySize.height.toInt(), Color.fromRGBO(170, 200, 154, 1));
        int xSpan = (bounds.xMin.abs()/xPrecision).round();
        int ySpan = (bounds.yMin.abs()/yPrecision).round();
        return GraphDisplay._internal(xSpan, ySpan, pixelMap, density,xPrecision,yPrecision);
  }

  static int _calculatePixels(int min, int max, int density){
    int range = (max - min);
    return range * density;
  }

  void _updatePosition(int x, int y, Color color){
    for(int i = x*density;i<((x+1)*density);i++){
      for(int j = y*density;j<((y+1)*density);j++){
        pixelMap.updatePixel(i, j, color);
      }
    }
  }

  void _plotCoordinates(Coordinates coordinates, Color color){
    int xPosition = _xOffset + (coordinates.x/xPrecision).round();
    int yPosition = _yOffset + (coordinates.y/yPrecision).round();

    _updatePosition(xPosition, yPosition, color);
  }

  void plotSegment(Coordinates start, Coordinates end, Color color){
    double farX = start.x.abs() > end.x.abs() ? start.x : end.x;

    double closeY = start.y.abs() > end.y.abs() ? end.y : start.y;
    double farY = start.y.abs() > end.y.abs() ? start.y : end.y;

    _plotCoordinates(start, Colors.purple);
    _plotCoordinates(end, Colors.purple);

    double yDirection = closeY < farY ? yPrecision : -1 * yPrecision;

    for(double i=closeY+yDirection;i!=farY;i+= yDirection){
      _plotCoordinates(Coordinates(farX, i.toDouble()), color);
    }
  }

  void displayLegend(Color color){
    for(int i = (-1)*_xOffset; i<_xOffset + 1; i++){
      _plotCoordinates(Coordinates(i.toDouble(),0), color);
    }

    for(int i = (-1)*_yOffset; i<_yOffset + 1; i++){
      _plotCoordinates(Coordinates(0,i.toDouble()), color);
    }
  }

  void displayCursor(Coordinates cursorLocation){
    int width = (24/density).round();
    for(int i = (cursorLocation.x-width).toInt(); i<(cursorLocation.x+width).toInt(); i++){
        _updatePosition(i, cursorLocation.y.toInt(), Colors.blue);
    }

    for(int i = (cursorLocation.y-width).toInt(); i<(cursorLocation.y+width).toInt(); i++){
      _updatePosition(cursorLocation.x.toInt(), i, Colors.blue);
    }
  }

  void render(ImageDecoderCallback callback){
    pixelMap.render(callback);
  }
}