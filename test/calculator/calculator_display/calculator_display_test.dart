import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';

void main(){

  CalculatorDisplayController _buildController([String inputLine='',List<DisplayHistory> history = const []]){
    CalculatorDisplayController controller = CalculatorDisplayController();
    controller.inputLine = inputLine;
    controller.history = history;
    return controller;
  }

  test('Calculator display mandates minimum number of lines',(){
    expect(() => CalculatorDisplay(_buildController(),numLines: 1), throwsAssertionError);
  });

  testWidgets('Calculator Display can be created',(WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController(),numLines: 2)));
    expect(find.byType(CalculatorDisplay),findsNWidgets(1));
  });

  group('Input line is displayed',(){
    group('with cursor',(){
      testWidgets('initially displayed',(WidgetTester tester) async{
        await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2+2'),numLines: 2)));
        expect(find.text('2+2█'),findsNWidgets(1));
      });
      testWidgets('blinking off',(WidgetTester tester) async{
        await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2+2'), numLines: 2)));
        await tester.pump(Duration(milliseconds: 500));
        expect(find.text('2+2⠀'),findsNWidgets(1));
      });

      testWidgets('blinking on',(WidgetTester tester) async{
        await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2+2'), numLines: 2)));
        await tester.pump(Duration(milliseconds: 1000));
        expect(find.text('2+2█'),findsNWidgets(1));
      });
      testWidgets('with cursor at specified location',(WidgetTester tester) async{
        CalculatorDisplayController controller = _buildController('2+2');
        controller.cursorIndex = 0;

        await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(controller, numLines: 2)));
        expect(find.text('█+2⠀'),findsNWidgets(1));
      });

      testWidgets('with cursor blinking at specified location',(WidgetTester tester) async{
        CalculatorDisplayController controller = _buildController('2+2');
        controller.cursorIndex = 0;

        await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(controller, numLines: 2)));
        await tester.pump(Duration(milliseconds: 500));
        expect(find.text('2+2⠀'),findsNWidgets(1));
      });
    });
    testWidgets('after controller updates',(WidgetTester tester) async{
      CalculatorDisplayController controller = _buildController('2+2');
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(controller, numLines: 2)));
      controller.inputLine = '3';
      await tester.pumpAndSettle();
      expect(find.text('3█'),findsNWidgets(1));
    });
  });

  group('History is displayed',(){
    testWidgets('Prior input with result',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2+2', [DisplayHistory('3+3', '6')]), numLines: 3)));
      expect(find.text('3+3'),findsNWidgets(1));
      expect(find.text('6'),findsNWidgets(1));
    });
    testWidgets('Result without specific input',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2+2', [DisplayHistory.result('6')]), numLines: 3)));
      expect(find.text('6'),findsNWidgets(1));
    });
    testWidgets('Result with blank input',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2+2', [DisplayHistory('','6')]), numLines: 3)));
      expect(find.text('6'),findsNWidgets(1));
    });
    testWidgets('after controller updates',(WidgetTester tester) async{
      CalculatorDisplayController controller = _buildController('2+2');
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(controller, numLines: 2)));
      controller.history = [DisplayHistory('3+3', '6')];
      await tester.pumpAndSettle();
      expect(find.text('3+3'),findsNWidgets(1));
      expect(find.text('6'),findsNWidgets(1));
    });
  });

  group('Widget updates',(){
    testWidgets('initially display input with cursor',(WidgetTester tester) async{
      //create widget twice to trigger update on second creation
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2+2+'), numLines: 2)));
      expect(find.text('2+2+█'),findsNWidgets(1));
    });

    testWidgets('display blinking cursor',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2+2+'), numLines: 2)));
      await tester.pump(Duration(milliseconds: 500));
      expect(find.text('2+2+⠀'),findsNWidgets(1));
    });
  });

  group('Ensure layout',(){
    testWidgets('standard layout',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2+2',[DisplayHistory('3+3', '6')]),numLines: 6)));
      await expectLater(find.byType(CalculatorDisplay),matchesGoldenFile('standard.png'));
    });

    testWidgets('scrolled to bottom',(WidgetTester tester) async{
      List<DisplayHistory> history = Iterable<int>.generate(100).toList().map((i)=> DisplayHistory('3+3', '6')).toList();
      await tester.pumpWidget(MaterialApp(home:CalculatorDisplay(_buildController('2', history),numLines: 6)));
      await tester.pumpAndSettle();
      await expectLater(find.byType(CalculatorDisplay),matchesGoldenFile('scrolled.png'));
    });
  });
}