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

  void updatePosition(int x, int y, Color color){
    for(int i = x*scale;i<((x+1)*scale);i++){
      for(int j = y*scale;j<((y+1)*scale);j++){
        pixelMap.updatePixel(i, j, color);
      }
    }
  }

  void displayLegend(cursorLocation){
    int horizontalMiddle = (height/2).round();
    int verticalMiddle = (width/2).round();

    for(int i = 0; i<width; i++){
        updatePosition(i, horizontalMiddle, Colors.black);
    }

    for(int i = 0; i<height; i++){
      updatePosition(verticalMiddle, i, Colors.black);
    }

    _updateCursor(cursorLocation);
  }

  void _updateCursor(cursorLocation){
    for(int i = cursorLocation[0]-8; i<cursorLocation[0]+8; i++){
        updatePosition(i, cursorLocation[1], Colors.red);
    }

    for(int i = cursorLocation[1]-8; i<cursorLocation[1]+8; i++){
      updatePosition(cursorLocation[0], i, Colors.red);
    }
  }

  void render(ImageDecoderCallback callback){
    pixelMap.render(callback);
  }
}