import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/pad/secondary_pad.dart';

void main(){
  bool Function(Widget) buttonPredicate = (widget) => widget is PadButton || widget is InputButton || widget is MultiButton;

  MaterialApp _buildTestable(Function(InputItem input) inputFunction, Function(CommandItem command) commandFunction){

    return MaterialApp(home:MediaQuery(
        data:MediaQueryData(size: Size(400,700), devicePixelRatio: 2.5),
        child:SecondaryPad(null,inputFunction,commandFunction)));
  }


  testWidgets('Button order',(WidgetTester tester) async{
    await tester.pumpWidget(_buildTestable((item){},(item){}));
    List<Widget> allButtons = tester.widgetList(find.byWidgetPredicate(buttonPredicate)).toList();

    Function(String, int) _verifyButtonLocation = (String display, int index){
      Widget matching = tester.widget(find.ancestor(of: find.text(display), matching: find.byWidgetPredicate(buttonPredicate)));
      expect(allButtons[index], matching);
    };

    _verifyButtonLocation('Back', 0,);
    _verifyButtonLocation(InputItem.OPEN_PARENTHESIS.display, 1);
    _verifyButtonLocation(InputItem.CLOSE_PARENTHESIS.display, 2);
    _verifyButtonLocation(CommandItem.DELETE.display, 3);
    _verifyButtonLocation(CommandItem.CLEAR.display, 4);
    _verifyButtonLocation(InputItem.SEC.display, 5);
    _verifyButtonLocation(InputItem.CSC.display, 5);
    _verifyButtonLocation(InputItem.COT.display, 5);
    _verifyButtonLocation(InputItem.COSH.display, 6);
    _verifyButtonLocation(InputItem.SINH.display, 6);
    _verifyButtonLocation(InputItem.TANH.display, 6);
    _verifyButtonLocation(InputItem.ACOS.display, 7);
    _verifyButtonLocation(InputItem.ASIN.display, 7);
    _verifyButtonLocation(InputItem.ATAN.display, 7);
    _verifyButtonLocation(InputItem.ASINH.display, 8);
    _verifyButtonLocation(InputItem.ACOSH.display, 8);
    _verifyButtonLocation(InputItem.ATANH.display, 8);
    _verifyButtonLocation(InputItem.DIVIDE.display, 9);
    _verifyButtonLocation(InputItem.SQUARE_ROOT.display, 10);
    _verifyButtonLocation(InputItem.E_POWER_X.display, 11);
    _verifyButtonLocation(InputItem.MULTIPLY.display, 14);
    _verifyButtonLocation(InputItem.SUBTRACT.display, 19);
    _verifyButtonLocation(InputItem.COMMA.display, 20);
    _verifyButtonLocation(InputItem.ADD.display, 24);
    _verifyButtonLocation('vars', 25);
    _verifyButtonLocation('a, b, c', 26);
    _verifyButtonLocation('list', 27);
    _verifyButtonLocation(CommandItem.ENTER.display, 29);
    expect(allButtons.length,30);
  });

  testWidgets('Button style',(WidgetTester tester) async{
    await tester.pumpWidget(_buildTestable((item){},(item){}));

    Function(String display, InputButtonStyle style) _verifyButtonStyle = (String display, InputButtonStyle style){
      Widget matching = tester.widget(find.ancestor(of: find.text(display), matching: find.byWidgetPredicate(buttonPredicate)));
      expect((matching as PadButton).style, style, reason: display);
    };

    _verifyButtonStyle('Back', InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.OPEN_PARENTHESIS.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.CLOSE_PARENTHESIS.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(CommandItem.DELETE.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(CommandItem.CLEAR.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.SEC.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.CSC.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.COT.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.COSH.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.SINH.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.TANH.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ACOS.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ASIN.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ATAN.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ASINH.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ACOSH.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ATANH.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.DIVIDE.display, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.SQUARE_ROOT.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.E_POWER_X.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.MULTIPLY.display, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.SUBTRACT.display, InputButtonStyle.SECONDARY);
    _verifyButtonStyle(InputItem.COMMA.display, InputButtonStyle.TERTIARY);
    _verifyButtonStyle(InputItem.ADD.display, InputButtonStyle.SECONDARY);
    _verifyButtonStyle('vars', InputButtonStyle.QUARTENARY);
    _verifyButtonStyle('a, b, c', InputButtonStyle.QUARTENARY);
    _verifyButtonStyle('list', InputButtonStyle.QUARTENARY);
    _verifyButtonStyle(CommandItem.ENTER.display, InputButtonStyle.SECONDARY);
  });
}