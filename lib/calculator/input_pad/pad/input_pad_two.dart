import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';


class InputPadTwo extends InputPad{

  InputPadTwo(storage,input, command) : super(storage,input, command);

  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    double availableHeight = MediaQuery.of(context).size.height;
    return Container(
      color:Colors.black38,
      alignment: Alignment.center,
      child:GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        childAspectRatio: availableWidth/availableHeight,
        physics: NeverScrollableScrollPhysics(),
        children:[
          PadButton('Back', InputButtonStyle.SECONDARY, () {Navigator.pushReplacementNamed(context, 'inputPadOne');}),
          buildInputButton(InputItem.OPEN_PARENTHESIS, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.CLOSE_PARENTHESIS, InputButtonStyle.TERTIARY),
          buildCommandButton('del',InputButtonStyle.TERTIARY),
          buildCommandButton('clear',InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.PI, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.CSC, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.SEC, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.COT, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.DIVIDE, InputButtonStyle.SECONDARY),
          buildInputButton(InputItem.E_POWER_X, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.SINH, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.COSH, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.TANH, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.MULTIPLY, InputButtonStyle.SECONDARY),
          buildInputButton(InputItem.INVERSE, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ASIN, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ACOS, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ATAN, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.SUBTRACT,  InputButtonStyle.SECONDARY),
          buildInputButton(InputItem.COMMA, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ASINH, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ACOSH, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ATANH, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ADD,  InputButtonStyle.SECONDARY),
          PadButton('Vars', InputButtonStyle.QUARTENARY, () {Navigator.pushReplacementNamed(context, 'varPad');}),
          MultiButton("A,B,C", inputFunction, InputButtonStyle.QUARTENARY, [
            InputItem.A,
            InputItem.B,
            InputItem.C,
            InputItem.D,
            InputItem.E,
            InputItem.F,
            InputItem.G
          ]),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.QUARTENARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.QUARTENARY),
          buildCommandButton('enter', InputButtonStyle.SECONDARY),
        ],
      )
    );
  }
}