import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';

void main() {

  group('Buttons',(){
    void _testInputButtonClick(WidgetTester tester, String text, String expectedValue) async{
      String actualValue = '';
      await tester.pumpWidget(MaterialApp(home:InputPad((text){actualValue = text;},(text){})));
      await tester.tap(find.text(text));

      expect(actualValue,expectedValue);
    }

    void _testCommandButtonClick(WidgetTester tester, String text, String expectedValue) async{
      String actualValue = '';
      await tester.pumpWidget(MaterialApp(home:InputPad((text){},(text){actualValue = text;})));
      await tester.tap(find.text(text));

      expect(actualValue,expectedValue);
    }

    void _testStyle(WidgetTester tester, String text, InputButtonStyle expectedStyle) async {
      await tester.pumpWidget(MaterialApp(home:InputPad((text){},(text){})));
      InputButton actualButton = tester.element(find.text(text)).findAncestorWidgetOfExactType<InputButton>();
      expect(actualButton.style, expectedStyle);
    }

    void _testButtonLocation(WidgetTester tester, String text, int expectedLocation) async {
      await tester.pumpWidget(MaterialApp(home:InputPad((text){},(text){})));
      List<Widget> allButtons = tester.widgetList(find.byType(InputButton)).toList();
      expect((allButtons[expectedLocation] as InputButton).text, text);
    }

    void _generateButtonTests(String text, String value, InputButtonStyle style, int location, [bool isCommand=false]){
      group(text,(){
        if(isCommand){
          testWidgets('executes command function when clicked with correct value',(WidgetTester tester) async{
            _testCommandButtonClick(tester,text,value);
          });
        }else{
          testWidgets('executes input function when clicked with correct value',(WidgetTester tester) async{
            _testInputButtonClick(tester,text,value);
          });
        }

        testWidgets('is styled correctly',(WidgetTester tester) async{
          _testStyle(tester,text, style);
        });

        testWidgets('is in correct location',(WidgetTester tester) async{
          _testButtonLocation(tester, text, location);
        });
      });
    }

    _generateButtonTests('sin','sin(',InputButtonStyle.TERTIARY,0);
    _generateButtonTests('cos','cos(',InputButtonStyle.TERTIARY,1);
    _generateButtonTests('tan','tan(',InputButtonStyle.TERTIARY,2);
    _generateButtonTests('del','del',InputButtonStyle.TERTIARY,3,true);
    _generateButtonTests('clear','clear',InputButtonStyle.TERTIARY,4,true);
    _generateButtonTests('𝑥 ⁻¹','⁻¹',InputButtonStyle.TERTIARY,5);
    _generateButtonTests('𝑥 ²','²',InputButtonStyle.TERTIARY,6);
    _generateButtonTests('(','(',InputButtonStyle.TERTIARY,7);
    _generateButtonTests(')',')',InputButtonStyle.TERTIARY,8);
    _generateButtonTests('÷','/',InputButtonStyle.SECONDARY,9);
    _generateButtonTests('^','^',InputButtonStyle.TERTIARY,10);
    _generateButtonTests('7','7',InputButtonStyle.PRIMARY,11);
    _generateButtonTests('8','8',InputButtonStyle.PRIMARY,12);
    _generateButtonTests('9','9',InputButtonStyle.PRIMARY,13);
    _generateButtonTests('x','*',InputButtonStyle.SECONDARY,14);
    _generateButtonTests('log','log(',InputButtonStyle.TERTIARY,15);
    _generateButtonTests('4','4',InputButtonStyle.PRIMARY,16);
    _generateButtonTests('5','5',InputButtonStyle.PRIMARY,17);
    _generateButtonTests('6','6',InputButtonStyle.PRIMARY,18);
    _generateButtonTests('-',' - ',InputButtonStyle.SECONDARY,19);
    _generateButtonTests('ln','ln(',InputButtonStyle.TERTIARY,20);
    _generateButtonTests('1','1',InputButtonStyle.PRIMARY,21);
    _generateButtonTests('2','2',InputButtonStyle.PRIMARY,22);
    _generateButtonTests('3','3',InputButtonStyle.PRIMARY,23);
    _generateButtonTests('+',' + ',InputButtonStyle.SECONDARY,24);
    _generateButtonTests(',',',',InputButtonStyle.TERTIARY,25);
    _generateButtonTests('0','0',InputButtonStyle.PRIMARY,26);
    _generateButtonTests('.','.',InputButtonStyle.PRIMARY,27);
    _generateButtonTests('−','-',InputButtonStyle.PRIMARY,28);
    _generateButtonTests('enter','enter',InputButtonStyle.SECONDARY,29,true);
  });

  group('Pad appearance',(){
    testWidgets('normal state',(WidgetTester tester) async{
      await tester.pumpWidget(MaterialApp(home:InputPad((text){},(text){})));
      await expectLater(find.byType(InputPad),matchesGoldenFile('pad-standard.png'));
    });
  });



}