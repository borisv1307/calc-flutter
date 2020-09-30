import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

class PixelMap{
  final int width;
  final int height;
  final Color _backgroundColor;
  final Int32List _pixels;


  PixelMap(this.width,this.height,this._backgroundColor):
    _pixels = Int32List(width * height);


  void _updatePixel(int x, int y, Color color){
    int pixel = (width * height) - (width - x) - (y*width);
    _pixels[pixel] = color.value;
  }

  void addLegend(cursorLocation){
    int horizontalMiddle = (height/2).round();
    int verticalMiddle = (width/2).round();

    for(int i = 0; i<width; i++){
      for(int j = horizontalMiddle-1;j<= horizontalMiddle+1;j++)
      _updatePixel(i, j, Colors.black);
    }

    for(int i = verticalMiddle-1; i<=verticalMiddle+1; i++){
      for(int j = 0;j< height;j++)
        _updatePixel(i, j, Colors.black);
    }

    _updateCursor(cursorLocation);
  }

  void moveCursor(String direction){

  }

  void _updateCursor(cursorLocation){
    for(int i = cursorLocation[0]-25; i<cursorLocation[0]+25; i++){
      for(int j = cursorLocation[1]-3;j<= cursorLocation[1]+2;j++)
        _updatePixel(i, j, Colors.red);
    }

    for(int i = cursorLocation[0]-3; i<cursorLocation[0]+3; i++){
      for(int j = cursorLocation[1]-25;j<= cursorLocation[1]+25;j++)
        _updatePixel(i, j, Colors.red);
    }
  }

  Uint8List asList(){
    for(int i=0; i < width*height;i++){
      if(_pixels[i]==0){
        _pixels[i] = _backgroundColor.value;
      }
    }
    return _pixels.buffer.asUint8List();
  }
}