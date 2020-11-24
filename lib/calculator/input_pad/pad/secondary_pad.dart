import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';


class SecondaryPad extends InputPad{

  SecondaryPad(storage,input, command) : super(storage,input, command);

  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    double availableHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      child:GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        childAspectRatio: availableWidth/availableHeight,
        physics: NeverScrollableScrollPhysics(),
        children:[
          PadButton('Back', InputButtonStyle.BLUE_LARGE_TEXT, () {Navigator.pushReplacementNamed(context, 'inputPadOne');}),
          buildInputButton(InputItem.OPEN_PARENTHESIS, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.CLOSE_PARENTHESIS, InputButtonStyle.BLACK_SMALL_TEXT),
          buildCommandButton(CommandItem.DELETE,InputButtonStyle.BLACK_SMALL_TEXT),
          buildCommandButton(CommandItem.CLEAR,InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.PI, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.CSC, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.SEC, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.COT, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.DIVIDE, InputButtonStyle.BLUE_LARGE_TEXT),
          buildInputButton(InputItem.E_POWER_X, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.SINH, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.COSH, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.TANH, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.MULTIPLY, InputButtonStyle.BLUE_LARGE_TEXT),
          buildInputButton(InputItem.NATURAL_LOG, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.ASIN, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.ACOS, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.ATAN, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.SUBTRACT,  InputButtonStyle.BLUE_LARGE_TEXT),
          buildInputButton(InputItem.INVERSE, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.COMMA, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.MAX, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.MIN, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.ADD,  InputButtonStyle.BLUE_LARGE_TEXT),
          buildInputButton(InputItem.STORAGE, InputButtonStyle.WHITE_LARGE_TEXT),
          PadButton('vars', InputButtonStyle.WHITE_LARGE_TEXT, () {Navigator.pushReplacementNamed(context, 'varPad');}),
          MultiButton("A,B,C", inputFunction, InputButtonStyle.WHITE_LARGE_TEXT, [
            InputItem.A,
            InputItem.B,
            InputItem.C,
            InputItem.D,
            InputItem.E,
            InputItem.F,
            InputItem.G
          ]),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.WHITE_LARGE_TEXT),
          buildCommandButton(CommandItem.ENTER, InputButtonStyle.BLUE_LARGE_TEXT),
        ],
      )
    );
  }
}