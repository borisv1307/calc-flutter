import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_calc/graph/coordinates.dart';
import 'package:open_calc/graph/pixel_map.dart';

class GraphDisplay{
  final int density;
  final int xSpan;
  final int ySpan;
  PixelMap pixelMap;

  GraphDisplay.bounds(int minX, int maxX, int minY, int maxY, this.density):
        assert(maxX > minX, 'Maximum x must be greater than minimum x'),
        assert(maxY > minY, 'Maximum y must be greater than minimum y'),
        pixelMap = PixelMap(((maxX-minX) + 1) * density,((maxY-minY) + 1) * density, Color.fromRGBO(170, 200, 154, 1)),
        this.xSpan = minX.abs(),
        this.ySpan = minY.abs();

  void _updatePosition(int x, int y, Color color){
    for(int i = x*density;i<((x+1)*density);i++){
      for(int j = y*density;j<((y+1)*density);j++){
        pixelMap.updatePixel(i, j, color);
      }
    }
  }

  void _plotCoordinates(Coordinates coordinates, Color color){
    int xPosition = xSpan + (coordinates.x).round();
    int yPosition = ySpan + (coordinates.y).round();

    _updatePosition(xPosition, yPosition, color);
  }

  void plotSegment(Coordinates start, Coordinates end, Color color){
    double farX = start.x.abs() > end.x.abs() ? start.x : end.x;

    double closeY = start.y.abs() > end.y.abs() ? end.y : start.y;
    double farY = start.y.abs() > end.y.abs() ? start.y : end.y;

    _plotCoordinates(start, Colors.purple);
    _plotCoordinates(end, Colors.purple);

    int yDirection = closeY < farY ? 1 : -1;

    for(int i=closeY.toInt()+yDirection;i!=farY.toInt();i+= yDirection){
      _plotCoordinates(Coordinates(farX, i.toDouble()), color);
    }
  }

  void displayLegend(Color color){
    for(int i = (-1)*xSpan; i<xSpan + 1; i++){
      _plotCoordinates(Coordinates(i.toDouble(),0), color);
    }

    for(int i = (-1)*ySpan; i<ySpan + 1; i++){
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