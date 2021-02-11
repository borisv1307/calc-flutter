import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph_analyzer.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:cartesian_graph/pixel_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'file:///C:/Users/Greg/IdeaProjects/se-calc/calc-flutter/lib/graph/graph_screen/interactive_graph/interactive_graph.dart';



class MockCartesianGraphAnalyzer extends Mock implements CartesianGraphAnalyzer{}

void main(){
  testWidgets("Tapping moves cursor", (WidgetTester tester) async {
    GraphCursor cursor = GraphCursor();
    cursor.location = Coordinates(5,7);

    MockCartesianGraphAnalyzer analyzer = MockCartesianGraphAnalyzer();
    when(analyzer.calculateCoordinates(PixelLocation(1200, -248))).thenReturn(Coordinates(4,5));
    Coordinates updatedCursor;
    await tester.pumpWidget(MaterialApp(home:InteractiveGraph([],Bounds(-1,1,-1,1),cursor,(Coordinates u){
      updatedCursor = u;
    },analyzer)));
    await tester.tapAt(Offset(400,300));
    expect(updatedCursor, Coordinates(4,5));
  });
}