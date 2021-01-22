import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';

class GraphPrimaryPad extends InputPad{

  GraphPrimaryPad(storage,input, command) : super(storage,input, command);
  
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
          PadButton('2nd', InputButtonStyle.SECONDARY, () {Navigator.pushReplacementNamed(context, 'inputPadTwo');}),
          buildInputButton(InputItem.X, InputButtonStyle(Colors.black, Colors.white, 24, BorderRadius.all(Radius.circular(10)))),
          buildInputButton(InputItem.POWER, InputButtonStyle.TERTIARY),
          buildCommandButton(CommandItem.DELETE,InputButtonStyle.TERTIARY),
          buildCommandButton(CommandItem.CLEAR,InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.SQUARED, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.INVERSE, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.OPEN_PARENTHESIS, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.CLOSE_PARENTHESIS, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.DIVIDE, InputButtonStyle.SECONDARY),
          buildInputButton(InputItem.PI, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.SEVEN, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.EIGHT, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.NINE, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.MULTIPLY, InputButtonStyle.SECONDARY),
          MultiButton([InputItem.SIN, InputItem.COS, InputItem.TAN], inputFunction, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.FOUR, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.FIVE, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.SIX, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.SUBTRACT, InputButtonStyle.SECONDARY),
          buildInputButton(InputItem.LOG, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ONE, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.TWO, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.THREE, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.ADD, InputButtonStyle.SECONDARY),
          buildInputButton(InputItem.NATURAL_LOG, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ZERO, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.DECIMAL, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.NEGATIVE, InputButtonStyle.PRIMARY),
          buildCommandButton(CommandItem.GRAPH, InputButtonStyle.SECONDARY),
        ],
      )
    );
  }
}
