import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/cartesian_graph/bounds.dart';
import 'package:open_calc/cartesian_graph/coordinates.dart';
import 'package:open_calc/cartesian_graph/graph_display.dart';
import 'package:open_calc/cartesian_graph/pixel_map.dart';


class MockPixelMap extends Mock implements PixelMap{}

void main() {

  group('Underlying Pixel Map', (){
    GraphDisplay graphDisplay;
    setUpAll((){
      graphDisplay = GraphDisplay.bounds(Bounds(-1,1,-2,2),2);
    });

    test('should have scaled width', () {
      expect(graphDisplay.pixelMap.width,6);
    });

    test('should have scaled height', () {
      expect(graphDisplay.pixelMap.height,10);
    });
  });

  group('Adjacent segment plotting unscaled',(){
    GraphDisplay graphDisplay;
    MockPixelMap mockPixelMap;
    setUp((){
      graphDisplay = GraphDisplay.bounds(Bounds(-1,1,-1,1),1);
      mockPixelMap = MockPixelMap();
      graphDisplay.pixelMap = mockPixelMap;
      graphDisplay.plotSegment(Coordinates(0,0), Coordinates(0,1), Colors.black);
    });
    
    test('should update 2 pixels',(){
      verify(mockPixelMap.updatePixel(any,any,any)).called(2);
    });

    test('should plot start point',(){
      var call = verify(mockPixelMap.updatePixel(1,1,captureAny));
      call.called(1);
      expect(call.captured[0].value,Colors.purple.value);
    });

    test('should plot end point',(){
      var call = verify(mockPixelMap.updatePixel(1,2,captureAny));
      call.called(1);
      expect(call.captured[0].value,Colors.purple.value);
    });
  });

  group('Adjacent segment plotting scaled',(){
    MockPixelMap mockPixelMap;
    setUp((){
      GraphDisplay graphDisplay = GraphDisplay.bounds(Bounds(-1,1,-1,1),2);
      mockPixelMap = MockPixelMap();
      graphDisplay.pixelMap = mockPixelMap;
      graphDisplay.plotSegment(Coordinates(0,0), Coordinates(0,1), Colors.black);
    });

    test('should update 8 pixels',(){
      verify(mockPixelMap.updatePixel(any,any,any)).called(8);
    });

    test('should plot start point',(){
      var call = verify(mockPixelMap.updatePixel(argThat(inInclusiveRange(2, 3)), argThat(inInclusiveRange(2, 3)),captureAny));
      call.called(4);
      call.captured.forEach((color) => expect(color.value,Colors.purple.value));
    });

    test('should plot end point',(){
      var call = verify(mockPixelMap.updatePixel(argThat(inInclusiveRange(2, 3)), argThat(inInclusiveRange(4, 5)),captureAny));
      call.called(4);
      call.captured.forEach((color) => expect(color.value,Colors.purple.value));
    });
  });

  group('Segment connection',(){
    MockPixelMap plotSegment(Coordinates start, Coordinates end){
      GraphDisplay graphDisplay = GraphDisplay.bounds(Bounds(-2,2,-2,2),1);
      MockPixelMap mockPixelMap = MockPixelMap();
      graphDisplay.pixelMap = mockPixelMap;
      graphDisplay.plotSegment(start, end, Colors.black);

      return mockPixelMap;
    }

    group('with increasing y',(){
      group('and increasing x',() {
        MockPixelMap mockPixelMap;
        setUp(() {
          mockPixelMap = plotSegment(Coordinates(0, 0), Coordinates(1, 2));
        });

        test('should update 3 pixels', () {
          verify(mockPixelMap.updatePixel(any, any, any)).called(3);
        });

        test('should plot connection', () {
          var call = verify(mockPixelMap.updatePixel(3, 3, captureAny));
          call.called(1);
          expect(call.captured[0].value, Colors.black.value);
        });
      });

      group('and decreasing x',(){
        MockPixelMap mockPixelMap;
        setUp(() {
          mockPixelMap = plotSegment(Coordinates(0, 0), Coordinates(-1, 2));
        });

        test('should update 3 pixels', () {
          verify(mockPixelMap.updatePixel(any, any, any)).called(3);
        });

        test('should plot connection', () {
          var call = verify(mockPixelMap.updatePixel(1, 3, captureAny));
          call.called(1);
          expect(call.captured[0].value, Colors.black.value);
        });
      });

    });

    group('with decreasing y',(){
      group('and increasing x',() {
        MockPixelMap mockPixelMap;
        setUp(() {
          mockPixelMap = plotSegment(Coordinates(0, 0), Coordinates(1, -2));
        });

        test('should update 3 pixels', () {
          verify(mockPixelMap.updatePixel(any, any, any)).called(3);
        });

        test('should plot connection', () {
          var call = verify(mockPixelMap.updatePixel(3, 1, captureAny));
          call.called(1);
          expect(call.captured[0].value, Colors.black.value);
        });
      });

      group('and decreasing x',(){
        MockPixelMap mockPixelMap;
        setUp(() {
          mockPixelMap = plotSegment(Coordinates(0, 0), Coordinates(-1, -2));
        });

        test('should update 3 pixels', () {
          verify(mockPixelMap.updatePixel(any, any, any)).called(3);
        });

        test('should plot connection', () {
          var call = verify(mockPixelMap.updatePixel(1, 1, captureAny));
          call.called(1);
          expect(call.captured[0].value, Colors.black.value);
        });
      });

    });
  });
}