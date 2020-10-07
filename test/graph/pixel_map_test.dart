import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/graph/pixel_map.dart';
import 'dart:ui' as ui;


void main() {
  group('Pixel  map creation', (){
    PixelMap pixelMap;
    setUp((){
      pixelMap = PixelMap(5,10,Colors.black);
    });
    test('should provide accurate width', () {

      expect(pixelMap.width,5);
    });

    test('should provide accurate height', () {
      PixelMap pixelMap = PixelMap(5,10,Colors.black);
      expect(pixelMap.height,10);
    });
  });

  group('Pixel updates',(){

    void callback(ui.Image image) async{
      Future byteData = image.toByteData();
      byteData.then((data){
        ByteData out = data;
        expect(Color(out.buffer.asInt32List()[0]).value, Colors.black.value);
        expect(Color(out.buffer.asInt32List()[1]).value, Colors.black.value);
        expect(Color(out.buffer.asInt32List()[2]).value, Colors.red.value);
        expect(Color(out.buffer.asInt32List()[3]).value, Colors.black.value);
      });
      expect(byteData,completes);
    }

    PixelMap pixelMap;
    setUp((){
      pixelMap = PixelMap(2,2,Colors.black);
    });

    test('should take effect',(){
      final c = Completer<ui.Image>();
      pixelMap.updatePixel(0, 0, Colors.red);
      pixelMap.render(expectAsync1(callback));
    });
  });
}