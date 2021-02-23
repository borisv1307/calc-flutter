import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/pad/pad_grid.dart';


class PrimaryPad extends StatelessWidget{
  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;

  PrimaryPad(this.inputFunction, this.commandFunction);


  Widget buildInputButton(InputItem inputItem, InputButtonStyle type){
    return InputButton(inputItem, type, inputFunction);
  }

  Widget buildCommandButton(CommandItem commandItem, InputButtonStyle type){
    return PadButton(commandItem.display, type, (){
      commandFunction(commandItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child:PadGrid([
        [
          PadButton('2nd', InputButtonStyle.SECONDARY, () {Navigator.pushReplacementNamed(context, 'inputPadTwo');}),
          buildInputButton(InputItem.PI, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ANSWER, InputButtonStyle.TERTIARY),
          buildCommandButton(CommandItem.DELETE,InputButtonStyle.TERTIARY),
          buildCommandButton(CommandItem.CLEAR,InputButtonStyle.TERTIARY),
        ],
        [
          buildInputButton(InputItem.SQUARED, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.POWER, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.OPEN_PARENTHESIS, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.CLOSE_PARENTHESIS, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.DIVIDE, InputButtonStyle.SECONDARY),
        ],
        [
          buildInputButton(InputItem.INVERSE, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.SEVEN, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.EIGHT, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.NINE, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.MULTIPLY, InputButtonStyle.SECONDARY),
        ],
        [
          MultiButton([InputItem.SIN, InputItem.COS, InputItem.TAN], inputFunction, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.FOUR, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.FIVE, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.SIX, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.SUBTRACT, InputButtonStyle.SECONDARY),
        ],
        [
          MultiButton([InputItem.LOG, InputItem.NATURAL_LOG], inputFunction, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ONE, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.TWO, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.THREE, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.ADD, InputButtonStyle.SECONDARY),
        ],
        [
          buildInputButton(InputItem.STORAGE, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ZERO, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.DECIMAL, InputButtonStyle.PRIMARY),
          buildInputButton(InputItem.NEGATIVE, InputButtonStyle.PRIMARY),
          buildCommandButton(CommandItem.ENTER, InputButtonStyle.SECONDARY),
        ]
        ])
      );
  }
}
