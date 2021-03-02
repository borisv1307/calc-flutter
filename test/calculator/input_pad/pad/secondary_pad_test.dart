import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/pad/secondary_pad.dart';


class MockContext extends Mock implements BuildContext{}

void main(){
  MockContext context = MockContext();  

  bool Function(Widget) buttonPredicate = (widget) => widget is PadButton || widget is InputButton || widget is MultiButton;

  MaterialApp _buildTestable(Function(InputItem input) inputFunction, Function(CommandItem command) commandFunction){

    return MaterialApp(home:MediaQuery(
        data:MediaQueryData(size: Size(400,700), devicePixelRatio: 2.5),
        child:SecondaryPad(inputFunction,commandFunction)));
  }


  testWidgets('Button order',(WidgetTester tester) async{
    await tester.pumpWidget(_buildTestable((item){},(item){}));
    List<Widget> allButtons = tester.widgetList(find.byWidgetPredicate(buttonPredicate)).toList();

    Function(String, int) _verifyButtonLocation = (String display, int index){
      Widget matching = tester.widget(find.ancestor(of: find.text(display), matching: find.byWidgetPredicate(buttonPredicate)));
      expect(allButtons[index], matching);
    };

    _verifyButtonLocation('Back', 0,);
    _verifyButtonLocation(InputItem.OPEN_PARENTHESIS.label, 1);
    _verifyButtonLocation(InputItem.CLOSE_PARENTHESIS.label, 2);
    _verifyButtonLocation(CommandItem.DELETE.display, 3);
    _verifyButtonLocation(CommandItem.CLEAR.display, 4);
    _verifyButtonLocation(InputItem.SEC.label, 5);
    _verifyButtonLocation(InputItem.CSC.label, 5);
    _verifyButtonLocation(InputItem.COT.label, 5);
    _verifyButtonLocation(InputItem.COSH.label, 6);
    _verifyButtonLocation(InputItem.SINH.label, 6);
    _verifyButtonLocation(InputItem.TANH.label, 6);
    _verifyButtonLocation(InputItem.ACOS.label, 7);
    _verifyButtonLocation(InputItem.ASIN.label, 7);
    _verifyButtonLocation(InputItem.ATAN.label, 7);
    _verifyButtonLocation(InputItem.ASINH.label, 8);
    _verifyButtonLocation(InputItem.ACOSH.label, 8);
    _verifyButtonLocation(InputItem.ATANH.label, 8);
    _verifyButtonLocation(InputItem.DIVIDE.label, 9);
    _verifyButtonLocation(InputItem.SQUARE_ROOT.label, 10);
    _verifyButtonLocation(InputItem.E_POWER_X.label, 11);
    _verifyButtonLocation(InputItem.MULTIPLY.label, 14);
    _verifyButtonLocation(InputItem.SUBTRACT.label, 19);
    _verifyButtonLocation(InputItem.COMMA.label, 20);
    _verifyButtonLocation(InputItem.ADD.label, 24);
    _verifyButtonLocation('vars', 25);
    _verifyButtonLocation('a, b, c', 26);
    _verifyButtonLocation('list', 27);
    _verifyButtonLocation('mode', 28);
    _verifyButtonLocation(CommandItem.ENTER.display, 29);
    expect(allButtons.length,30);
  });

  testWidgets('Button style',(WidgetTester tester) async{
    await tester.pumpWidget(_buildTestable((item){},(item){}));

    Function(String display, InputButtonStyle style) _verifyButtonStyle = (String display, InputButtonStyle style){
      Widget matching = tester.widget(find.ancestor(of: find.text(display), matching: find.byWidgetPredicate(buttonPredicate)));
      expect((matching as PadButton).style, style, reason: display);
    };

    _verifyButtonStyle('Back', InputButtonStyle.secondary(context));
    _verifyButtonStyle(InputItem.OPEN_PARENTHESIS.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.CLOSE_PARENTHESIS.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(CommandItem.DELETE.display, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(CommandItem.CLEAR.display, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.SEC.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.CSC.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.COT.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.COSH.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.SINH.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.TANH.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.ACOS.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.ASIN.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.ATAN.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.ASINH.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.ACOSH.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.ATANH.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.DIVIDE.label, InputButtonStyle.secondary(context));
    _verifyButtonStyle(InputItem.SQUARE_ROOT.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.E_POWER_X.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.MULTIPLY.label, InputButtonStyle.secondary(context));
    _verifyButtonStyle(InputItem.SUBTRACT.label, InputButtonStyle.secondary(context));
    _verifyButtonStyle(InputItem.COMMA.label, InputButtonStyle.tertiary(context));
    _verifyButtonStyle(InputItem.ADD.label, InputButtonStyle.secondary(context));
    _verifyButtonStyle('vars', InputButtonStyle.quartenary(context));
    _verifyButtonStyle('a, b, c', InputButtonStyle.quartenary(context));
    _verifyButtonStyle('list', InputButtonStyle.quartenary(context));
    _verifyButtonStyle('mode', InputButtonStyle.quartenary(context));
    _verifyButtonStyle(CommandItem.ENTER.display, InputButtonStyle.secondary(context));
  });
}