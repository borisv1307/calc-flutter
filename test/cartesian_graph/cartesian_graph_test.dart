import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/cartesian_graph/bounds.dart';
import 'package:open_calc/cartesian_graph/cartesian_graph.dart';
import 'package:open_calc/cartesian_graph/display/display_size.dart';
import 'dart:ui' as ui;

import 'package:open_calc/cartesian_graph/display/graph_display.dart';

class MockGraphDisplay extends Mock implements GraphDisplay {


  @override
  void render(ImageDecoderCallback callback) async{
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    ui.Image image = await recorder.endRecording().toImage(5, 5);
    callback(image);
  }

}

class MockImage extends Mock implements ui.Image{}

class TestableCartesianGraph extends CartesianGraph{
  final GraphDisplay _graphDisplay;

  TestableCartesianGraph(this._graphDisplay);

  @override
  GraphDisplay createGraphDisplay(Bounds bounds, DisplaySize displaySize, int density){
    return _graphDisplay;
  }
}
void main() {
  Widget _makeTestable(CartesianGraph graph){
    return MediaQuery(data: MediaQueryData(), child: MaterialApp(home:graph));
  }

  testWidgets(('Cartesian Graph'), (WidgetTester tester) async{

    MockGraphDisplay mockGraphDisplay = MockGraphDisplay();

    await tester.pumpWidget(_makeTestable(TestableCartesianGraph(mockGraphDisplay)));
    expect(find.byType(CircularProgressIndicator),findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}