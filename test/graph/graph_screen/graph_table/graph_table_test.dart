import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_details/graph_table/graph_table.dart';


void main() {
  double calculateEquation(String equation, double x) {
    return x;
  }

  Widget _buildTestableTable(List<String> equations) {
    ScaleSettings scaleSettings = ScaleSettings(-1, 1, -1, 1, 1);
    return MaterialApp(home: Scaffold(body: GraphTable(equations, scaleSettings, calculateEquation)));
  }


  group('table', () {
  
    testWidgets('displays labels', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableTable(['x']));
      expect(find.text('x'),findsNWidgets(1));
      expect(find.text('y₁'),findsNWidgets(1));
      expect(find.text('y₂'),findsNWidgets(1));
      expect(find.text('y₃'),findsNWidgets(1));
    });

    testWidgets('displays correct number of items', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableTable(['x', 'x', 'x']));
      expect(find.byType(Text),findsNWidgets(4 + 3 * 4));
      expect(find.text('-1'),findsNWidgets(4));
      expect(find.text('0'),findsNWidgets(4));
      expect(find.text('1'),findsNWidgets(4));
    });

    testWidgets('right arrow shifts equations', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableTable(['x', 'x']));
      await tester.tap(find.byIcon(Icons.keyboard_arrow_right));
      await tester.pumpAndSettle();
      expect(find.text('y₂'),findsNWidgets(1));
      expect(find.text('y₃'),findsNWidgets(1));
      expect(find.text('y₄'),findsNWidgets(1));
      expect(find.text('-1'),findsNWidgets(2));
      expect(find.text('0'),findsNWidgets(2));
      expect(find.text('1'),findsNWidgets(2));
    });

    testWidgets('left arrow is initially hidden, then appears', (WidgetTester tester) async {
      await tester.pumpWidget(_buildTestableTable(['x', 'x']));
      expect(find.byIcon(Icons.keyboard_arrow_left),findsNothing);
      await tester.tap(find.byIcon(Icons.keyboard_arrow_right));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.keyboard_arrow_left),findsNWidgets(1));
    });

  });
}