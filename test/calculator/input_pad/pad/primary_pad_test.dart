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
    _verifyButtonLocation(InputItem.PI.display, 1);
    _verifyButtonLocation(InputItem.ANSWER.display, 2);
    _verifyButtonLocation(CommandItem.DELETE.display, 3);
    _verifyButtonLocation(CommandItem.CLEAR.display, 4);
    _verifyButtonLocation(InputItem.SQUARED.display, 5);
    _verifyButtonLocation(InputItem.POWER.display, 6);
    _verifyButtonLocation(InputItem.OPEN_PARENTHESIS.display, 7);
    _verifyButtonLocation(InputItem.CLOSE_PARENTHESIS.display, 8);
    _verifyButtonLocation(InputItem.DIVIDE.display, 9);
    _verifyButtonLocation(InputItem.INVERSE.display, 10);
    _verifyButtonLocation(InputItem.SEVEN.display, 11);
    _verifyButtonLocation(InputItem.EIGHT.display, 12);
    _verifyButtonLocation(InputItem.NINE.display, 13);
    _verifyButtonLocation(InputItem.MULTIPLY.display, 14);
    _verifyButtonLocation(InputItem.COS.display, 15);
    _verifyButtonLocation(InputItem.SIN.display, 15);
    _verifyButtonLocation(InputItem.TAN.display, 15);
    _verifyButtonLocation(InputItem.FOUR.display, 16);
    _verifyButtonLocation(InputItem.FIVE.display, 17);
    _verifyButtonLocation(InputItem.SIX.display, 18);
    _verifyButtonLocation(InputItem.SUBTRACT.display, 19);
    _verifyButtonLocation(InputItem.LOG.display, 20);
    _verifyButtonLocation(InputItem.NATURAL_LOG.display, 20);
    _verifyButtonLocation(InputItem.ONE.display, 21);
    _verifyButtonLocation(InputItem.TWO.display, 22);
    _verifyButtonLocation(InputItem.THREE.display, 23);
    _verifyButtonLocation(InputItem.ADD.display, 24);
    _verifyButtonLocation(InputItem.STORAGE.display, 25);
    _verifyButtonLocation(InputItem.ZERO.display, 26);
    _verifyButtonLocation(InputItem.DECIMAL.display, 27);
    _verifyButtonLocation(InputItem.NEGATIVE.display, 28);
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
    _verifyButtonStyle(InputItem.PI.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ANSWER.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(CommandItem.DELETE.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(CommandItem.CLEAR.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.SQUARED.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.POWER.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.OPEN_PARENTHESIS.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.CLOSE_PARENTHESIS.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.DIVIDE.display, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.INVERSE.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.SEVEN.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.EIGHT.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.NINE.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.MULTIPLY.display, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.COS.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.SIN.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.TAN.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.FOUR.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.FIVE.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.SIX.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.SUBTRACT.display, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.LOG.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.NATURAL_LOG.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ONE.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.TWO.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.THREE.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.ADD.display, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.STORAGE.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ZERO.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.DECIMAL.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(InputItem.NEGATIVE.display, InputButtonStyle.PRIMARY);
    _verifyButtonStyle(CommandItem.ENTER.display, InputButtonStyle.SECONDARY);
  });
}