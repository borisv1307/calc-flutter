import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/mode/mode_dialog.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main(){
  testWidgets('Close dialog', (WidgetTester tester) async{
    MockNavigatorObserver observer = MockNavigatorObserver();
    await tester.pumpWidget(MaterialApp(home:ModeDialog(CalculationOptions()),navigatorObservers: [observer],));
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    verify(observer.didPop(any, any));
  });

  group('Decimal places',(){
    testWidgets('are displayed', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:ModeDialog(CalculationOptions())));
      await tester.tap(find.text('max'));
      await tester.pumpAndSettle();
      expect(find.text('Decimal places'), findsWidgets);
      expect(find.text('max'), findsWidgets);
      expect(find.text('0'), findsWidgets);
      expect(find.text('1'), findsWidgets);
      expect(find.text('2'), findsWidgets);
      expect(find.text('3'), findsWidgets);
      expect(find.text('4'), findsWidgets);
      expect(find.text('5'), findsWidgets);
      expect(find.text('6'), findsWidgets);
      expect(find.text('7'), findsWidgets);
      expect(find.text('8'), findsWidgets);
      expect(find.text('9'), findsWidgets);
    });

    testWidgets('can be updated', (WidgetTester tester) async{
      CalculationOptions options = CalculationOptions();
      await tester.pumpWidget(MaterialApp(home:ModeDialog(options)));
      await tester.tap(find.text('max'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('3').last);
      expect(options.decimalPlaces,3);
    });
  });

  group('Angular unit',(){
    testWidgets('are displayed', (WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:ModeDialog(CalculationOptions())));
      await tester.tap(find.text('radian'));
      await tester.pumpAndSettle();
      expect(find.text('Angular unit'), findsWidgets);
      expect(find.text('radian'), findsWidgets);
      expect(find.text('degree'), findsWidgets);
    });

    testWidgets('can be updated', (WidgetTester tester) async{
      CalculationOptions options = CalculationOptions();
      await tester.pumpWidget(MaterialApp(home:ModeDialog(options)));
      await tester.tap(find.text('radian'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('degree').last);
      await tester.pumpAndSettle();
      expect(options.angularUnit,AngularUnit.DEGREE);
    });
  });
}