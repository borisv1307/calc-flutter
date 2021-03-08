import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockCalculatorDisplayController extends Mock implements CalculatorDisplayController{
  String inputLine = '';
  int cursorIndex = 0;
  List<DisplayHistory> history = [];
}

void main(){
  SettingsController settingsController;

  CalculatorDisplayController _buildController([List<InputItem> inputItems=const []]){
    CalculatorDisplayController controller = CalculatorDisplayController();
    inputItems.forEach((inputItem)=>controller.input(inputItem));
    return controller;
  }

  Widget _buildCalcScreen(CalculatorDisplayController controller) {
    return Builder(
      builder: (BuildContext context) {
        return SettingsControllerProvider(
          controller: settingsController,
          child: MaterialApp(
            home: CalculatorDisplay(controller)
          )
        );
      }
    );
  }

  setUp(() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    settingsController = SettingsController(pref);
  });


  testWidgets('Calculator Display can be created',(WidgetTester tester) async{
    await tester.pumpWidget(_buildCalcScreen(_buildController()));
    expect(find.byType(CalculatorDisplay),findsNWidgets(1));
  });

  group('Input line is displayed',(){
    group('with cursor',(){
      testWidgets('initially displayed',(WidgetTester tester) async{
        await tester.pumpWidget(_buildCalcScreen(_buildController([InputItem.NEGATIVE, InputItem.TWO,InputItem.ADD,InputItem.TWO])));
        expect(find.text('-2+2█'),findsNWidgets(1));
      });
      testWidgets('blinking off',(WidgetTester tester) async{
        await tester.pumpWidget(_buildCalcScreen(_buildController([InputItem.TWO,InputItem.ADD,InputItem.TWO])));
        await tester.pump(Duration(milliseconds: 500));
        expect(find.text('2+2⠀'),findsNWidgets(1));
      });

      testWidgets('blinking on',(WidgetTester tester) async{
        await tester.pumpWidget(_buildCalcScreen(_buildController([InputItem.TWO,InputItem.ADD,InputItem.TWO])));
        await tester.pump(Duration(milliseconds: 1000));
        expect(find.text('2+2█'),findsNWidgets(1));
      });
      testWidgets('with cursor at specified location',(WidgetTester tester) async{
        CalculatorDisplayController controller = _buildController([InputItem.TWO,InputItem.ADD,InputItem.TWO]);
        controller.cursorIndex = 0;

        await tester.pumpWidget(_buildCalcScreen(controller));
        expect(find.text('█+2⠀'),findsNWidgets(1));
      });

      testWidgets('with cursor blinking at specified location',(WidgetTester tester) async{
        CalculatorDisplayController controller = _buildController([InputItem.TWO,InputItem.ADD,InputItem.TWO]);
        controller.cursorIndex = 0;

        await tester.pumpWidget(_buildCalcScreen(controller));
        await tester.pump(Duration(milliseconds: 500));
        expect(find.text('2+2⠀'),findsNWidgets(1));
      });
    });
    testWidgets('after controller updates',(WidgetTester tester) async{
      CalculatorDisplayController controller = _buildController([InputItem.TWO,InputItem.ADD,InputItem.TWO]);
      await tester.pumpWidget(_buildCalcScreen(controller));
      controller.clearInput();
      controller.input(InputItem.THREE);
      await tester.pumpAndSettle();
      expect(find.text('3█'),findsNWidgets(1));
    });
  });

  group('Cursor movement',(){
    testWidgets('occurs on tap',(WidgetTester tester) async{
      CalculatorDisplayController controller = _buildController([InputItem.ONE,InputItem.TWO,InputItem.THREE, InputItem.FOUR]);
      await tester.pumpWidget(_buildCalcScreen(controller));
      await tester.tapAt(tester.getTopLeft(find.byType(TextField)));
      await tester.pump();
      expect(find.text('█234⠀'),findsNWidgets(1));
    });
  });

  group('History is loaded from storage and displayed',(){
    testWidgets('History is loaded',(WidgetTester tester) async{
      settingsController.setCalcHistory([
        DisplayHistory([InputItem.TWO, InputItem.ADD, InputItem.THREE], "5"),
        DisplayHistory([InputItem.SEVEN, InputItem.ADD, InputItem.ONE], "8"),
      ]);
      await tester.pumpWidget(_buildCalcScreen(_buildController()));
      expect(find.text('2+3'),findsNWidgets(1));
      expect(find.text('5'),findsNWidgets(1));
      expect(find.text('7+1'),findsNWidgets(1));
      expect(find.text('8'),findsNWidgets(1));

    });
    testWidgets('Prior input with result',(WidgetTester tester) async{
      CalculatorDisplayController controller = _buildController([InputItem.TWO,InputItem.ADD,InputItem.TWO]);
      await tester.pumpWidget(_buildCalcScreen(controller));
      controller.history = [DisplayHistory([InputItem.THREE,InputItem.ADD,InputItem.THREE], '6')];
      await tester.pumpAndSettle();
      expect(find.text('3+3'),findsNWidgets(1));
      expect(find.text('6'),findsNWidgets(1));
    });
    testWidgets('Result with blank input',(WidgetTester tester) async{
      CalculatorDisplayController controller = _buildController([InputItem.TWO,InputItem.ADD,InputItem.TWO]);
      await tester.pumpWidget(_buildCalcScreen(controller));
      controller.history =  [DisplayHistory([],'6')];
      await tester.pumpAndSettle();
      expect(find.text('6'),findsNWidgets(1));
    });
  });

  group('Widget updates',(){
    testWidgets('initially display input with cursor',(WidgetTester tester) async{
      //create widget twice to trigger update on second creation
      await tester.pumpWidget(_buildCalcScreen(_buildController([InputItem.TWO,InputItem.ADD,InputItem.TWO, InputItem.ADD])));
      expect(find.text('2+2+█'),findsNWidgets(1));
    });

    testWidgets('display blinking cursor',(WidgetTester tester) async{
      await tester.pumpWidget(_buildCalcScreen(_buildController([InputItem.TWO,InputItem.ADD,InputItem.TWO, InputItem.ADD])));
      await tester.pump(Duration(milliseconds: 500));
      expect(find.text('2+2+⠀'),findsNWidgets(1));
    });
  });

  group('Gestures browse history',(){
    testWidgets('browses backwards when swipe down',(WidgetTester tester) async{
      MockCalculatorDisplayController controller = MockCalculatorDisplayController();
      await tester.pumpWidget(_buildCalcScreen(controller));
      await tester.fling(find.byType(TextField), Offset(0,100),200);
      verify(controller.browseBackwards()).called(1);
    });

    testWidgets('browses forwards when swipe up',(WidgetTester tester) async{
      MockCalculatorDisplayController controller = MockCalculatorDisplayController();
      await tester.pumpWidget(_buildCalcScreen(controller));
      await tester.fling(find.byType(TextField), Offset(0,-100),200);
      verify(controller.browseForwards()).called(1);
    });
  });

  group('Alerts are displayed',(){
    testWidgets('when alert is provided',(WidgetTester tester) async{
      CalculatorDisplayController controller = CalculatorDisplayController();
      await tester.pumpWidget(_buildCalcScreen(controller));
      controller.pushAlert('Test alert');
      await tester.pumpAndSettle();
      expect(find.text('TEST ALERT'),findsOneWidget);
      await tester.pump(Duration(milliseconds: 500));
    });
  });

  group('Ensure layout',(){
    testWidgets('standard layout',(WidgetTester tester) async{
      CalculatorDisplayController controller = _buildController([InputItem.TWO, InputItem.ADD, InputItem.TWO]);
      await tester.pumpWidget(_buildCalcScreen(controller));
      controller.history = [DisplayHistory([InputItem.ONE,InputItem.TWO,InputItem.THREE], '6')];
      await tester.pumpAndSettle();
      await expectLater(find.byType(CalculatorDisplay),matchesGoldenFile('standard.png'));
    });

    testWidgets('input line overflow',(WidgetTester tester) async{
      List<InputItem> input = List<InputItem>.generate(40, (i) => InputItem.TWO).toList();
      await tester.pumpWidget(_buildCalcScreen(_buildController(input)));
      await expectLater(find.byType(CalculatorDisplay),matchesGoldenFile('overflow.png'));
    });

    testWidgets('scrolled to bottom',(WidgetTester tester) async{
      CalculatorDisplayController controller = _buildController([InputItem.TWO]);
      await tester.pumpWidget(_buildCalcScreen(controller));
      List<DisplayHistory> history = Iterable<int>.generate(100).toList().map((i)=> DisplayHistory([InputItem.ONE,InputItem.TWO,InputItem.THREE], '6')).toList();
      controller.history = history;
      await tester.pumpAndSettle();
      await expectLater(find.byType(CalculatorDisplay),matchesGoldenFile('scrolled.png'));
    });

    testWidgets('text wraps to new line',(WidgetTester tester) async{
      List<InputItem> input = [];
      for (var i = 0; i < 45; i++) {
        input.add(InputItem.THREE);
      }
      CalculatorDisplayController controller = _buildController(input);
      await tester.pumpWidget(_buildCalcScreen(controller));
      controller.history = [DisplayHistory([InputItem.ONE,InputItem.TWO,InputItem.THREE], '6')];
      await tester.pumpAndSettle();
      await expectLater(find.byType(CalculatorDisplay),matchesGoldenFile('textwrap.png'));
    });
  });
}