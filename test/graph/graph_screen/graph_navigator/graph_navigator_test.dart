import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/graph_navigator.dart';

void main(){
  Widget _buildTestableNavigator(Coordinates cursorLocation,Function(Coordinates updatedLocation) moveCursor){
    GraphCursor cursor = GraphCursor();
    cursor.location = cursorLocation;
    return MaterialApp(home:GraphNavigator(cursor, moveCursor));
  }

  group('Legend',(){
    testWidgets("x coordinate displayed ", (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableNavigator(Coordinates(5,7),(Coordinates u){}));
      expect(find.text('x = 5.0'), findsOneWidget);
    });

    testWidgets("y coordinate displayed ", (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableNavigator(Coordinates(5,7),(Coordinates u){}));
      expect(find.text('y = 7.0'), findsOneWidget);
    });
  });

  group('Arrows',(){
    testWidgets("can navigate cursor up", (WidgetTester tester) async {
      Coordinates updatedCoordinates;
      await tester.pumpWidget(_buildTestableNavigator(Coordinates(0,0),(Coordinates u){
        updatedCoordinates = u;
      }));
      await tester.tap(find.byIcon(Icons.arrow_upward));
      await tester.pumpAndSettle();
      expect(updatedCoordinates, Coordinates(0, 3));
    });

    testWidgets("can navigate cursor right", (WidgetTester tester) async {
      Coordinates updatedCoordinates;
      await tester.pumpWidget(_buildTestableNavigator(Coordinates(0,0),(Coordinates u){
        updatedCoordinates = u;
      }));
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pumpAndSettle();
      expect(updatedCoordinates, Coordinates(3, 0));
    });

    testWidgets("can navigate cursor down", (WidgetTester tester) async {
      Coordinates updatedCoordinates;
      await tester.pumpWidget(_buildTestableNavigator(Coordinates(0,0),(Coordinates u){
        updatedCoordinates = u;
      }));
      await tester.tap(find.byIcon(Icons.arrow_downward));
      await tester.pumpAndSettle();
      expect(updatedCoordinates, Coordinates(0, -3));
    });

    testWidgets("can navigate cursor left", (WidgetTester tester) async {
      Coordinates updatedCoordinates;
      await tester.pumpWidget(_buildTestableNavigator(Coordinates(0,0),(Coordinates u){
        updatedCoordinates = u;
      }));
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(updatedCoordinates, Coordinates(-3, 0));
    });
  });
}