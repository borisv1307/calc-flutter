import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/pad/primary_pad.dart';

void main(){
  bool Function(Widget) buttonPredicate = (widget) => widget is PadButton || widget is InputButton || widget is MultiButton;

  MaterialApp _buildTestable(Function(InputItem input) inputFunction, Function(CommandItem command) commandFunction){

    return MaterialApp(home:MediaQuery(
        data:MediaQueryData(size: Size(400,700), devicePixelRatio: 2.5),
        child:PrimaryPad(null,inputFunction,commandFunction)));
  }


  testWidgets('Button order',(WidgetTester tester) async{
    await tester.pumpWidget(_buildTestable((item){},(item){}));
    List<Widget> allButtons = tester.widgetList(find.byWidgetPredicate(buttonPredicate)).toList();

    Function(String, int) _verifyButtonLocation = (String display, int index){
      Widget matching = tester.widget(find.ancestor(of: find.text(display), matching: find.byWidgetPredicate(buttonPredicate)));
      expect(allButtons[index], matching);
    };

    _verifyButtonLocation('2nd', 0,);
    _verifyButtonLocation(InputItem.PI.label, 1);
    _verifyButtonLocation(InputItem.ANSWER.label, 2);
    _verifyButtonLocation(CommandItem.DELETE.display, 3);
    _verifyButtonLocation(CommandItem.CLEAR.display, 4);
    _verifyButtonLocation(InputItem.SQUARED.label, 5);
    _verifyButtonLocation(InputItem.POWER.label, 6);
    _verifyButtonLocation(InputItem.OPEN_PARENTHESIS.label, 7);
    _verifyButtonLocation(InputItem.CLOSE_PARENTHESIS.label, 8);
    _verifyButtonLocation(InputItem.DIVIDE.label, 9);
    _verifyButtonLocation(InputItem.INVERSE.label, 10);
    _verifyButtonLocation(InputItem.SEVEN.label, 11);
    _verifyButtonLocation(InputItem.EIGHT.label, 12);
    _verifyButtonLocation(InputItem.NINE.label, 13);
    _verifyButtonLocation(InputItem.MULTIPLY.label, 14);
    _verifyButtonLocation(InputItem.COS.label, 15);
    _verifyButtonLocation(InputItem.SIN.label, 15);
    _verifyButtonLocation(InputItem.TAN.label, 15);
    _verifyButtonLocation(InputItem.FOUR.label, 16);
    _verifyButtonLocation(InputItem.FIVE.label, 17);
    _verifyButtonLocation(InputItem.SIX.label, 18);
    _verifyButtonLocation(InputItem.SUBTRACT.label, 19);
    _verifyButtonLocation(InputItem.LOG.label, 20);
    _verifyButtonLocation(InputItem.NATURAL_LOG.label, 20);
    _verifyButtonLocation(InputItem.ONE.label, 21);
    _verifyButtonLocation(InputItem.TWO.label, 22);
    _verifyButtonLocation(InputItem.THREE.label, 23);
    _verifyButtonLocation(InputItem.ADD.label, 24);
    _verifyButtonLocation(InputItem.STORAGE.label, 25);
    _verifyButtonLocation(InputItem.ZERO.label, 26);
    _verifyButtonLocation(InputItem.DECIMAL.label, 27);
    _verifyButtonLocation(InputItem.NEGATIVE.label, 28);
    _verifyButtonLocation(CommandItem.ENTER.display, 29);
    expect(allButtons.length,30);
  });

  testWidgets('Button style',(WidgetTester tester) async{
    await tester.pumpWidget(_buildTestable((item){},(item){}));

    Function(String display, InputButtonStyle style) _verifyButtonStyle = (String display, InputButtonStyle style){
      Widget matching = tester.widget(find.ancestor(of: find.text(display), matching: find.byWidgetPredicate(buttonPredicate)));
      expect((matching as PadButton).style, style);
    };

    _verifyButtonStyle('2nd', InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.PI.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ANSWER.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(CommandItem.DELETE.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(CommandItem.CLEAR.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.SQUARED.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.POWER.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.OPEN_PARENTHESIS.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.CLOSE_PARENTHESIS.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.DIVIDE.label, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.INVERSE.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.SEVEN.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.EIGHT.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.NINE.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.MULTIPLY.label, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.COS.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.SIN.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.TAN.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.FOUR.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.FIVE.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.SIX.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.SUBTRACT.label, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.LOG.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.NATURAL_LOG.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ONE.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.TWO.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.THREE.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.ADD.label, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.STORAGE.label, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ZERO.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.DECIMAL.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.NEGATIVE.label, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(CommandItem.ENTER.display, InputButtonStyle.SECONDARY);
  });
}