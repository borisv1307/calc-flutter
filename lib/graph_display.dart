import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_calc/pixel_map.dart';

class GraphDisplay{
  final int scale;
  final int width;
  final int height;
  final PixelMap pixelMap;

  GraphDisplay(this.width, this.height, this.scale):
      pixelMap = PixelMap(width*scale,height*scale, Color.fromRGBO(170, 200, 154, 1));

  void _updatePosition(int x, int y, Color color){
    for(int i = x*scale;i<((x+1)*scale);i++){
      for(int j = y*scale;j<((y+1)*scale);j++){
        pixelMap.updatePixel(i, j, color);
      }
    }
  }

  void plotCoordinates(double x, double y, Color color){
    int xMid = (width/2).round();
    int yMid = (height/2).round();

    int xPosition = xMid + (x*scale).round();
    int yPosition = yMid + (y*scale).round();

    _updatePosition(xPosition, yPosition, color);
  }

  void displayLegend(cursorLocation){
    int horizontalMiddle = (height/2).round();
    int verticalMiddle = (width/2).round();

    for(int i = 0; i<width; i++){
        _updatePosition(i, horizontalMiddle, Colors.grey[700]);
    }

    for(int i = 0; i<height; i++){
      _updatePosition(verticalMiddle, i, Colors.grey[700]);
    }

    _updateCursor(cursorLocation);
  }

  void _updateCursor(cursorLocation){
    int width = (24/scale).round();
    for(int i = cursorLocation[0]-width; i<cursorLocation[0]+width; i++){
        _updatePosition(i, cursorLocation[1], Colors.red);
    }

    for(int i = cursorLocation[1]-width; i<cursorLocation[1]+width; i++){
      _updatePosition(cursorLocation[0], i, Colors.red);
    }
  }

  void render(ImageDecoderCallback callback){

    pixelMap.render(callback);
  }
}