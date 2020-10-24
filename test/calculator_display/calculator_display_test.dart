import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator_display/display_history.dart';

void main(){

  test('Calculator display mandates minimum number of lines',(){
    expect(() => CalculatorDisplay(1), throwsAssertionError);
  });

  testWidgets('Calculator Display can be created',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(2)));
    expect(find.byType(CalculatorDisplay),findsNWidgets(1));
  });

  group('Input line is displayed',(){
    testWidgets('initially with cursor',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(2,inputLine:'2+2')));
      expect(find.text('2+2█'),findsNWidgets(1));
    });
    testWidgets('with blinking cursor',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(2, inputLine:'2+2')));
      await tester.pump(Duration(milliseconds: 500));
      expect(find.text('2+2⠀'),findsNWidgets(1));
    });
  });

  group('History is displayed',(){
    testWidgets('Prior input with result',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(3,inputLine:'2+2',history:[DisplayHistory('3+3', '6')])));
      expect(find.text('3+3'),findsNWidgets(1));
      expect(find.text('6'),findsNWidgets(1));
    });
    testWidgets('Result without specific input',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(3, inputLine:'2+2',history:[DisplayHistory.result('6')])));
      expect(find.text('6'),findsNWidgets(1));
    });
    testWidgets('Result with blank input',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(3, inputLine:'2+2',history:[DisplayHistory('','6')])));
      expect(find.text('6'),findsNWidgets(1));
    });
  });

  group('Widget updates',(){
    testWidgets('initially display input with cursor',(WidgetTester tester) async{
      //create widget twice to trigger update on second creation
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(2, inputLine:'2+2')));
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(2, inputLine: '2+2+')));
      expect(find.text('2+2+█'),findsNWidgets(1));
    });

    testWidgets('display blinking cursor',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(2, inputLine:'2+2')));
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(2, inputLine:'2+2+')));
      await tester.pump(Duration(milliseconds: 500));
      expect(find.text('2+2+⠀'),findsNWidgets(1));
    });
  });

  group('Ensure layout',(){
    testWidgets('standard layout',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(6,inputLine:'2+2',history:[DisplayHistory('3+3', '6')])));
      await expectLater(find.byType(CalculatorDisplay),matchesGoldenFile('standard.png'));
    });

    testWidgets('scrolled to bottom',(WidgetTester tester) async{
      List<DisplayHistory> history = Iterable<int>.generate(100).toList().map((i)=> DisplayHistory('3+3', '6')).toList();
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(6, inputLine:'2',history:history)));
      await tester.pumpAndSettle();
      await expectLater(find.byType(CalculatorDisplay),matchesGoldenFile('scrolled.png'));
    });
  });
}