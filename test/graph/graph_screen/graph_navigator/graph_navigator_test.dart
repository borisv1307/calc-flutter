import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/graph_navigator.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle/text_toggle_selection.dart';

void main(){
  Widget _buildTestableNavigator(GraphCursor cursor){
    ScaleSettings scaleSettings = ScaleSettings();
    scaleSettings.step = 3;
    return MaterialApp(home:GraphNavigator(cursor, TextToggleSelection('equations'), scaleSettings));
  }

  group('Arrows',(){
    testWidgets("can navigate cursor up", (WidgetTester tester) async {
      GraphCursor cursor = GraphCursor(Coordinates(0,0));
      await tester.pumpWidget(_buildTestableNavigator(cursor));
      await tester.tap(find.byIcon(Icons.arrow_upward));
      await tester.pumpAndSettle();
      expect(cursor.location, Coordinates(0, 3));
    });

    testWidgets("can navigate cursor right", (WidgetTester tester) async {
      GraphCursor cursor = GraphCursor(Coordinates(0,0));
      await tester.pumpWidget(_buildTestableNavigator(cursor));
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(cursor.location, Coordinates(3, 0));
    });

    testWidgets("can navigate cursor down", (WidgetTester tester) async {
      GraphCursor cursor = GraphCursor(Coordinates(0,0));
      await tester.pumpWidget(_buildTestableNavigator(cursor));
      await tester.tap(find.byIcon(Icons.arrow_downward));
      await tester.pumpAndSettle();
      expect(cursor.location, Coordinates(0, -3));
    });

    testWidgets("can navigate cursor left", (WidgetTester tester) async {
      GraphCursor cursor = GraphCursor(Coordinates(0,0));
      await tester.pumpWidget(_buildTestableNavigator(cursor));
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(cursor.location, Coordinates(-3, 0));
    });
  });
}