import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import '../input_pad.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';


class PrimaryPad extends InputPad{

  PrimaryPad(storage,input, command) : super(storage,input, command);
  
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
          PadButton('2nd', InputButtonStyle.BLUE_LARGE_TEXT, () {Navigator.pushReplacementNamed(context, 'inputPadTwo');}),
          buildInputButton(InputItem.OPEN_PARENTHESIS, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.CLOSE_PARENTHESIS, InputButtonStyle.BLACK_SMALL_TEXT),
          buildCommandButton(CommandItem.DELETE,InputButtonStyle.BLACK_SMALL_TEXT),
          buildCommandButton(CommandItem.CLEAR,InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.SQUARE_ROOT, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.SIN, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.COS, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.TAN, InputButtonStyle.BLACK_SMALL_TEXT),          
          buildInputButton(InputItem.DIVIDE, InputButtonStyle.BLUE_LARGE_TEXT),
          buildInputButton(InputItem.LOG, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.SEVEN, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.EIGHT, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.NINE, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.MULTIPLY, InputButtonStyle.BLUE_LARGE_TEXT),
          buildInputButton(InputItem.POWER, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.FOUR, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.FIVE, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.SIX, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.SUBTRACT, InputButtonStyle.BLUE_LARGE_TEXT),
          buildInputButton(InputItem.SQUARED, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.ONE, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.TWO, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.THREE, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.ADD, InputButtonStyle.BLUE_LARGE_TEXT),
          buildInputButton(InputItem.ANSWER, InputButtonStyle.BLACK_SMALL_TEXT),
          buildInputButton(InputItem.ZERO, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.DECIMAL, InputButtonStyle.WHITE_ROUNDED),
          buildInputButton(InputItem.NEGATIVE, InputButtonStyle.WHITE_ROUNDED),
          buildCommandButton(CommandItem.ENTER, InputButtonStyle.BLUE_LARGE_TEXT),
        ],
      )
    );
  }
}
