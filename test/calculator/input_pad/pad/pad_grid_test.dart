import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/pad/pad_grid.dart';

void main(){
  testWidgets('Adjacent items',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: PadGrid([[Text('A'),Text('B')]])));
    await expectLater(find.byType(PadGrid),matchesGoldenFile('pad_grid_adjacent.png'));
  });

  testWidgets('Rows of items',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home: PadGrid([[Text('A')],[Text('B')]])));
    await expectLater(find.byType(PadGrid),matchesGoldenFile('pad_grid_rows.png'));
  });
}