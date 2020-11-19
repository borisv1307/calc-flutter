import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

void main() {
  group('Buttons',(){
    void _testInputButtonClick(WidgetTester tester, InputItem expectedValue, int screen) async{
      InputItem actualValue;
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(inputItem){actualValue = inputItem;},(text){})));
      if (screen == 2) {
        await tester.tap(find.text("2nd"));
        await tester.pumpAndSettle(new Duration(milliseconds: 50));
        await tester.tap(find.text(expectedValue.display).last);
      } else {
        await tester.tap(find.text(expectedValue.display).first);
      }
      expect(actualValue, expectedValue);
    }

    void _testCommandButtonClick(WidgetTester tester, CommandItem commandItem, int screen) async{
      CommandItem actualValue;
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(command){},(command){actualValue = command;})));
      if (screen == 2) {
        await tester.tap(find.text("2nd"));
        await tester.pumpAndSettle(new Duration(milliseconds: 50));
        await tester.tap(find.text(commandItem.display).last);
      } else {
        await tester.tap(find.text(commandItem.display).first);
      }
      expect(actualValue,commandItem);
    }

    void _testCommandStyle(WidgetTester tester, String text, InputButtonStyle expectedStyle, int screen) async {
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){})));
      if (screen == 2) {
        await tester.tap(find.text("2nd"));
        await tester.pumpAndSettle(new Duration(milliseconds: 50));
      }
      PadButton actualButton = tester.element(find.text(text)).findAncestorWidgetOfExactType<PadButton>();
      expect(actualButton.style, expectedStyle);
    }

    void _testInputStyle(WidgetTester tester, String text, InputButtonStyle expectedStyle, int screen) async {
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){})));
      if (screen == 2) {
        await tester.tap(find.text("2nd"));
        await tester.pumpAndSettle(new Duration(milliseconds: 50));
      }
      InputButton actualButton = tester.element(find.text(text)).findAncestorWidgetOfExactType<InputButton>();
      expect(actualButton.style, expectedStyle);
    }

    void _testButtonLocation(WidgetTester tester, String text, int expectedLocation, int screen) async {
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){})));
      if (screen == 2) {
        await tester.tap(find.text("2nd"));
        await tester.pumpAndSettle(new Duration(milliseconds: 50));
      }
      List<Widget> allButtons = tester.widgetList(find.byWidgetPredicate((Widget widget) => widget is InputButton || widget is PadButton)).toList();
      expect((allButtons[expectedLocation] as PadButton).display, text);
    }

    void _generateInputButtonTests(InputItem inputItem, InputButtonStyle style, int location, int screen){
      group(inputItem.display,(){
        testWidgets('executes input function when clicked with correct value',(WidgetTester tester) async{
          _testInputButtonClick(tester,inputItem,screen);
        });

        testWidgets('is styled correctly',(WidgetTester tester) async{
          _testInputStyle(tester,inputItem.display,style,screen);
        });

        testWidgets('is in correct location',(WidgetTester tester) async{
          _testButtonLocation(tester,inputItem.display,location,screen);
        });
      });
    }

    void _generateCommandButtonTests(CommandItem commandItem, String display, InputButtonStyle style, int location, int screen){
      group(commandItem.display,(){
        testWidgets('executes command function when clicked with correct value',(WidgetTester tester) async{
          _testCommandButtonClick(tester,commandItem,screen);
        });

        testWidgets('is styled correctly',(WidgetTester tester) async{
          _testCommandStyle(tester,commandItem.display,style,screen);
        });

        testWidgets('is in correct location',(WidgetTester tester) async{
          _testButtonLocation(tester,commandItem.display,location,screen);
        });
      });
    }

    void _generateSpecialtyButtonTests(String text, InputButtonStyle style, int location, int screen){
      group(text,(){
        testWidgets('is styled correctly',(WidgetTester tester) async{
          _testCommandStyle(tester,text,style,screen);
        });

        testWidgets('is in correct location',(WidgetTester tester) async{
          _testButtonLocation(tester,text,location,screen);
        });
      });
    }


    _generateSpecialtyButtonTests('2nd',InputButtonStyle.SECONDARY,0,1);
    _generateInputButtonTests(InputItem.OPEN_PARENTHESIS,InputButtonStyle.TERTIARY,1,1);
    _generateInputButtonTests(InputItem.CLOSE_PARENTHESIS,InputButtonStyle.TERTIARY,2,1);
    _generateCommandButtonTests(CommandItem.DELETE,'del',InputButtonStyle.TERTIARY,3,1);
    _generateCommandButtonTests(CommandItem.CLEAR,'clear',InputButtonStyle.TERTIARY,4,1);
    _generateInputButtonTests(InputItem.SQUARED,InputButtonStyle.TERTIARY,5,1);
    _generateInputButtonTests(InputItem.SIN,InputButtonStyle.TERTIARY,6,1);
    _generateInputButtonTests(InputItem.COS,InputButtonStyle.TERTIARY,7,1);
    _generateInputButtonTests(InputItem.TAN,InputButtonStyle.TERTIARY,8,1);
    _generateInputButtonTests(InputItem.DIVIDE,InputButtonStyle.SECONDARY,9,1);
    _generateInputButtonTests(InputItem.POWER,InputButtonStyle.TERTIARY,10,1);
    _generateInputButtonTests(InputItem.SEVEN,InputButtonStyle.PRIMARY,11,1);
    _generateInputButtonTests(InputItem.EIGHT,InputButtonStyle.PRIMARY,12,1);
    _generateInputButtonTests(InputItem.NINE,InputButtonStyle.PRIMARY,13,1);
    _generateInputButtonTests(InputItem.MULTIPLY,InputButtonStyle.SECONDARY,14,1);
    _generateInputButtonTests(InputItem.LOG,InputButtonStyle.TERTIARY,15,1);
    _generateInputButtonTests(InputItem.FOUR,InputButtonStyle.PRIMARY,16,1);
    _generateInputButtonTests(InputItem.FIVE,InputButtonStyle.PRIMARY,17,1);
    _generateInputButtonTests(InputItem.SIX,InputButtonStyle.PRIMARY,18,1);
    _generateInputButtonTests(InputItem.SUBTRACT,InputButtonStyle.SECONDARY,19,1);
    _generateInputButtonTests(InputItem.NATURAL_LOG,InputButtonStyle.TERTIARY,20,1);
    _generateInputButtonTests(InputItem.ONE,InputButtonStyle.PRIMARY,21,1);
    _generateInputButtonTests(InputItem.TWO,InputButtonStyle.PRIMARY,22,1);
    _generateInputButtonTests(InputItem.THREE,InputButtonStyle.PRIMARY,23,1);
    _generateInputButtonTests(InputItem.ADD,InputButtonStyle.SECONDARY,24,1);
    _generateInputButtonTests(InputItem.STORAGE,InputButtonStyle.TERTIARY,25,1);
    _generateInputButtonTests(InputItem.ZERO,InputButtonStyle.PRIMARY,26,1);
    _generateInputButtonTests(InputItem.DECIMAL,InputButtonStyle.PRIMARY,27,1);
    _generateInputButtonTests(InputItem.NEGATIVE,InputButtonStyle.PRIMARY,28,1);
    _generateCommandButtonTests(CommandItem.ENTER,'enter',InputButtonStyle.SECONDARY,29,1);

    _generateSpecialtyButtonTests('Back',InputButtonStyle.SECONDARY,0,2);
    _generateInputButtonTests(InputItem.OPEN_PARENTHESIS,InputButtonStyle.TERTIARY,1,2);
    _generateInputButtonTests(InputItem.CLOSE_PARENTHESIS,InputButtonStyle.TERTIARY,2,2);
    _generateCommandButtonTests(CommandItem.DELETE,'del',InputButtonStyle.TERTIARY,3,2);
    _generateCommandButtonTests(CommandItem.CLEAR,'clear',InputButtonStyle.TERTIARY,4,2);
    _generateInputButtonTests(InputItem.PI,InputButtonStyle.TERTIARY,5,2);
    _generateInputButtonTests(InputItem.CSC,InputButtonStyle.TERTIARY,6,2);
    _generateInputButtonTests(InputItem.SEC,InputButtonStyle.TERTIARY,7,2);
    _generateInputButtonTests(InputItem.COT,InputButtonStyle.TERTIARY,8,2);
    _generateInputButtonTests(InputItem.DIVIDE,InputButtonStyle.SECONDARY,9,2);
    _generateInputButtonTests(InputItem.E_POWER_X,InputButtonStyle.TERTIARY,10,2);
    _generateInputButtonTests(InputItem.SINH,InputButtonStyle.TERTIARY,11,2);
    _generateInputButtonTests(InputItem.COSH,InputButtonStyle.TERTIARY,12,2);
    _generateInputButtonTests(InputItem.TANH,InputButtonStyle.TERTIARY,13,2);
    _generateInputButtonTests(InputItem.MULTIPLY,InputButtonStyle.SECONDARY,14,2);
    _generateInputButtonTests(InputItem.INVERSE,InputButtonStyle.TERTIARY,15,2);
    _generateInputButtonTests(InputItem.ASIN,InputButtonStyle.TERTIARY,16,2);
    _generateInputButtonTests(InputItem.ACOS,InputButtonStyle.TERTIARY,17,2);
    _generateInputButtonTests(InputItem.ATAN,InputButtonStyle.TERTIARY,18,2);
    _generateInputButtonTests(InputItem.SUBTRACT,InputButtonStyle.SECONDARY,19,2);
    _generateInputButtonTests(InputItem.COMMA,InputButtonStyle.TERTIARY,20,2);
    _generateInputButtonTests(InputItem.ASINH,InputButtonStyle.TERTIARY,21,2);
    _generateInputButtonTests(InputItem.ACOSH,InputButtonStyle.TERTIARY,22,2);
    _generateInputButtonTests(InputItem.ATANH,InputButtonStyle.TERTIARY,23,2);
    _generateInputButtonTests(InputItem.ADD,InputButtonStyle.SECONDARY,24,2);
    _generateSpecialtyButtonTests('Vars',InputButtonStyle.QUARTENARY,25,2);
    _generateCommandButtonTests(CommandItem.ENTER,'enter',InputButtonStyle.SECONDARY,29,2);

  });

  group('Pad appearance',(){
    testWidgets('normal state',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){},)));
      await expectLater(find.byType(InputPad),matchesGoldenFile('pad-standard.png'));
    });

    testWidgets('second state',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){},)));
      await tester.tap(find.text("2nd"));
      await tester.pumpAndSettle(new Duration(milliseconds: 50));
      await expectLater(find.byType(InputPad),matchesGoldenFile('pad-2nd.png'));
    });
  });



}