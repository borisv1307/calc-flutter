import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/pad/pad_grid.dart';

class GraphPrimaryPad extends StatelessWidget{
  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;

  GraphPrimaryPad(this.inputFunction, this.commandFunction);

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
          PadButton('2nd', InputButtonStyle.secondary(context), () {Navigator.pushReplacementNamed(context, 'inputPadTwo');}),
          buildInputButton(InputItem.X, InputButtonStyle(Colors.black, Theme.of(context).colorScheme.primary, 24, BorderRadius.all(Radius.circular(10)))),
          buildInputButton(InputItem.POWER, InputButtonStyle.tertiary(context)),
          buildCommandButton(CommandItem.DELETE,InputButtonStyle.tertiary(context)),
          buildCommandButton(CommandItem.CLEAR,InputButtonStyle.tertiary(context)),
        ],
        [
          buildInputButton(InputItem.SQUARED, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.INVERSE, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.OPEN_PARENTHESIS, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.CLOSE_PARENTHESIS, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.DIVIDE, InputButtonStyle.secondary(context)),
        ],
        [
          buildInputButton(InputItem.PI, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.SEVEN, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.EIGHT, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.NINE, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.MULTIPLY, InputButtonStyle.secondary(context)),
        ],
        [
          MultiButton([InputItem.SIN, InputItem.COS, InputItem.TAN], inputFunction, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.FOUR, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.FIVE, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.SIX, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.SUBTRACT, InputButtonStyle.secondary(context)),
        ],
        [
          buildInputButton(InputItem.LOG, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.ONE, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.TWO, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.THREE, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.ADD, InputButtonStyle.secondary(context)),
        ],
        [
          buildInputButton(InputItem.NATURAL_LOG, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.ZERO, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.DECIMAL, InputButtonStyle.primary(context)),
          buildInputButton(InputItem.NEGATIVE, InputButtonStyle.primary(context)),
          buildCommandButton(CommandItem.GRAPH, InputButtonStyle.secondary(context)),
        ]
      ],
      )
    );
  }
}
