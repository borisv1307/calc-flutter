import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_calc/graph/coordinates.dart';
import 'package:open_calc/graph/pixel_map.dart';

class GraphDisplay{
  final int scale;
  final int xSpan;
  final int ySpan;
  PixelMap pixelMap;

  GraphDisplay(int width, int height, this.scale):
      pixelMap = PixelMap(width*scale,height*scale, Color.fromRGBO(170, 200, 154, 1)),
      this.xSpan = ((width-1)/2).round(),
      this.ySpan = ((height-1)/2).round();

  void _updatePosition(int x, int y, Color color){
    for(int i = x*scale;i<((x+1)*scale);i++){
      for(int j = y*scale;j<((y+1)*scale);j++){
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

  void displayLegend(cursorLocation){
    for(int i = (-1)*xSpan; i<xSpan + 1; i++){
      _plotCoordinates(Coordinates(i.toDouble(),0), Colors.grey[700]);
    }

    for(int i = (-1)*ySpan; i<ySpan + 1; i++){
      _plotCoordinates(Coordinates(0,i.toDouble()), Colors.grey[700]);
    }

    _updateCursor(cursorLocation);
  }

  void _updateCursor(cursorLocation){
    int width = (24/scale).round();
    for(int i = cursorLocation[0]-width; i<cursorLocation[0]+width; i++){
        _updatePosition(i, cursorLocation[1], Colors.blue);
    }

    for(int i = cursorLocation[1]-width; i<cursorLocation[1]+width; i++){
      _updatePosition(cursorLocation[0], i, Colors.blue);
    }
  }

  void render(ImageDecoderCallback callback){
    pixelMap.render(callback);
  }
}