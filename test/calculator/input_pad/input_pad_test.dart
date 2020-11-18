import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

List<List<List<String>>> matrixStorage = [[['0']]];
List<String> matrixMathList;
void main() {
  group('Buttons',(){

    void _testInputButtonClick(WidgetTester tester, InputItem expectedValue) async{
      InputItem actualValue;
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(inputItem){actualValue = inputItem;},(text){},matrixStorage,matrixMathList)));
      await tester.tap(find.text(expectedValue.display));


      expect(actualValue,expectedValue);
    }

    void _testCommandButtonClick(WidgetTester tester, String text, String expectedValue) async{
      String actualValue = '';
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){actualValue = text;},matrixStorage,matrixMathList)));
      await tester.tap(find.text(text));

      expect(actualValue,expectedValue);
    }


    void _testCommandStyle(WidgetTester tester, String text, InputButtonStyle expectedStyle) async {
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){},matrixStorage,matrixMathList)));
      PadButton actualButton = tester.element(find.text(text)).findAncestorWidgetOfExactType<PadButton>();
      expect(actualButton.style, expectedStyle);
    }

    void _testInputStyle(WidgetTester tester, String text, InputButtonStyle expectedStyle) async {
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){},matrixStorage,matrixMathList)));
      InputButton actualButton = tester.element(find.text(text)).findAncestorWidgetOfExactType<InputButton>();
      expect(actualButton.style, expectedStyle);
    }

    void _testButtonLocation(WidgetTester tester, String text, int expectedLocation) async {
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){},matrixStorage,matrixMathList)));
      List<Widget> allButtons = tester.widgetList(find.byWidgetPredicate((Widget widget) => widget is InputButton || widget is PadButton)).toList();
      expect((allButtons[expectedLocation] as PadButton).display, text);

    }

    void _generateInputButtonTests(InputItem inputItem, InputButtonStyle style, int location){
      group(inputItem.display,(){
        testWidgets('executes input function when clicked with correct value',(WidgetTester tester) async{
          _testInputButtonClick(tester,inputItem);
        });

        testWidgets('is styled correctly',(WidgetTester tester) async{
          _testInputStyle(tester,inputItem.display,style);
        });

        testWidgets('is in correct location',(WidgetTester tester) async{
          _testButtonLocation(tester, inputItem.display, location);
        });
      });
    }

    void _generateCommandButtonTests(String text, String display, InputButtonStyle style, int location){
      group(text,(){
        testWidgets('executes command function when clicked with correct value',(WidgetTester tester) async{
          _testCommandButtonClick(tester,text,display);
        });

        testWidgets('is styled correctly',(WidgetTester tester) async{
          _testCommandStyle(tester,text,style);
        });

        testWidgets('is in correct location',(WidgetTester tester) async{
          _testButtonLocation(tester, text, location);
        });
      });
    }

    _generateInputButtonTests(InputItem.SIN,InputButtonStyle.TERTIARY,0);
    _generateInputButtonTests(InputItem.COS,InputButtonStyle.TERTIARY,1);
    _generateInputButtonTests(InputItem.TAN,InputButtonStyle.TERTIARY,2);
    _generateCommandButtonTests('del','del',InputButtonStyle.TERTIARY,3);
    _generateCommandButtonTests('clear','clear',InputButtonStyle.TERTIARY,4);
  // _generateButtonTests('𝑥 ⁻¹','⁻¹',InputButtonStyle.TERTIARY,5);
    _generateInputButtonTests(InputItem.SQUARED,InputButtonStyle.TERTIARY,5);
    _generateInputButtonTests(InputItem.OPEN_PARENTHESIS,InputButtonStyle.TERTIARY,6);
    _generateInputButtonTests(InputItem.CLOSE_PARENTHESIS,InputButtonStyle.TERTIARY,7);
    _generateInputButtonTests(InputItem.DIVIDE,InputButtonStyle.SECONDARY,8);
    _generateInputButtonTests(InputItem.POWER,InputButtonStyle.TERTIARY,9);
    _generateInputButtonTests(InputItem.SEVEN,InputButtonStyle.PRIMARY,10);
    _generateInputButtonTests(InputItem.EIGHT,InputButtonStyle.PRIMARY,11);
    _generateInputButtonTests(InputItem.NINE,InputButtonStyle.PRIMARY,12);
    _generateInputButtonTests(InputItem.MULTIPLY,InputButtonStyle.SECONDARY,13);
    _generateInputButtonTests(InputItem.LOG,InputButtonStyle.TERTIARY,14);
    _generateInputButtonTests(InputItem.FOUR,InputButtonStyle.PRIMARY,15);
    _generateInputButtonTests(InputItem.FIVE,InputButtonStyle.PRIMARY,16);
    _generateInputButtonTests(InputItem.SIX,InputButtonStyle.PRIMARY,17);
    _generateInputButtonTests(InputItem.SUBTRACT,InputButtonStyle.SECONDARY,18);
    _generateInputButtonTests(InputItem.NATURAL_LOG,InputButtonStyle.TERTIARY,19);
    _generateInputButtonTests(InputItem.ONE,InputButtonStyle.PRIMARY,20);
    _generateInputButtonTests(InputItem.TWO,InputButtonStyle.PRIMARY,21);
    _generateInputButtonTests(InputItem.THREE,InputButtonStyle.PRIMARY,22);
    _generateInputButtonTests(InputItem.ADD,InputButtonStyle.SECONDARY,23);
    _generateCommandButtonTests('sto','sto',InputButtonStyle.TERTIARY,24);
    _generateInputButtonTests(InputItem.ZERO,InputButtonStyle.PRIMARY,25);
    _generateInputButtonTests(InputItem.DECIMAL,InputButtonStyle.PRIMARY,26);
    _generateInputButtonTests(InputItem.NEGATIVE,InputButtonStyle.PRIMARY,27);
    _generateCommandButtonTests('enter','enter',InputButtonStyle.SECONDARY,28);
  });

  group('Pad appearance',(){
    testWidgets('normal state',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputPad(VariableStorage(),(text){},(text){},matrixStorage,matrixMathList)));
      await expectLater(find.byType(InputPad),matchesGoldenFile('pad-standard.png'));
    });
  });



}
