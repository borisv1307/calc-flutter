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
  ui.Image _image;

  MockGraphDisplay(this._image);

  @override
  void render(ImageDecoderCallback callback) async{
    callback(_image);
  }

}

class MockImage extends Mock implements ui.Image{}

class TestableCartesianGraph extends CartesianGraph{
  final GraphDisplay _graphDisplay;
  Bounds bounds;
  DisplaySize displaySize;
  int density;

  TestableCartesianGraph(Bounds bounds, this._graphDisplay): super(bounds);

  @override
  GraphDisplay createGraphDisplay(Bounds bounds, DisplaySize displaySize, int density){
    this.bounds = bounds;
    this.displaySize = displaySize;
    this.density = density;
    return _graphDisplay;
  }
}
void main() {
  Widget _makeTestable(CartesianGraph graph){
    return MediaQuery(data: MediaQueryData(), child: MaterialApp(home:graph));
  }

  Future<ui.Image> _createMockImage() async{
    PictureRecorder recorder = PictureRecorder();
    Canvas(recorder);
    ui.Image image = await recorder.endRecording().toImage(5, 5);
    return image;
  }

  group('Graph Display is created', (){

  });

  testWidgets(('Cartesian Graph initially shows progress indicator'), (WidgetTester tester) async{
    MockGraphDisplay mockGraphDisplay = MockGraphDisplay(await _createMockImage());
    await tester.pumpWidget(_makeTestable(TestableCartesianGraph(Bounds(-1,1,-1,1), mockGraphDisplay)));
    expect(find.byType(CircularProgressIndicator),findsOneWidget);
  });

  testWidgets(('Cartesian Graph displays image'), (WidgetTester tester) async{
    var mockImage = await _createMockImage();
    MockGraphDisplay mockGraphDisplay = MockGraphDisplay(mockImage);
    await tester.pumpWidget(_makeTestable(TestableCartesianGraph(Bounds(-1,1,-1,1),mockGraphDisplay)));
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(RawImage), findsNWidgets(1));

    RawImage rawImage = find.byType(RawImage).evaluate().single.widget as RawImage;
    expect(rawImage.image,mockImage);
  });
}