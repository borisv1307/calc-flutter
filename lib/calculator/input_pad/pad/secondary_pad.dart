import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/catalog/catalog_dialog.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/button/multi_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/mode/mode_dialog.dart';
import 'package:open_calc/calculator/input_pad/pad/pad_grid.dart';


class SecondaryPad extends StatelessWidget{
  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;
  final CalculationOptions options;

  SecondaryPad(this.inputFunction, this.commandFunction, this.options);

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
          PadButton('Back', InputButtonStyle.secondary(context), () {Navigator.pushReplacementNamed(context, 'inputPadOne');}),
          buildInputButton(InputItem.OPEN_PARENTHESIS, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.CLOSE_PARENTHESIS, InputButtonStyle.tertiary(context)),
          buildCommandButton(CommandItem.DELETE,InputButtonStyle.tertiary(context)),
          buildCommandButton(CommandItem.CLEAR,InputButtonStyle.tertiary(context)),
        ],
        [
          MultiButton([InputItem.CSC, InputItem.SEC, InputItem.COT], inputFunction, InputButtonStyle.tertiary(context)),
          MultiButton([InputItem.SINH, InputItem.COSH, InputItem.TANH], inputFunction, InputButtonStyle.tertiary(context)),
          MultiButton([InputItem.ASIN, InputItem.ACOS, InputItem.ATAN], inputFunction, InputButtonStyle.tertiary(context)),
          MultiButton([InputItem.ASINH, InputItem.ACOSH, InputItem.ATANH], inputFunction, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.DIVIDE, InputButtonStyle.secondary(context)),
        ],
        [
          buildInputButton(InputItem.SQUARE_ROOT, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.E_POWER_X, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.MULTIPLY, InputButtonStyle.secondary(context)),
        ],
        [
          buildInputButton(InputItem.EMPTY, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.SUBTRACT,  InputButtonStyle.secondary(context)),
        ],
        [
          buildInputButton(InputItem.COMMA, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.tertiary(context)),
          buildInputButton(InputItem.ADD,  InputButtonStyle.secondary(context)),
        ],
        [
          PadButton('vars', InputButtonStyle.quartenary(context), () {Navigator.pushReplacementNamed(context, 'varPad');}),
          MultiButton([
            InputItem.A,
            InputItem.B,
            InputItem.C,
            InputItem.D,
            InputItem.E,
            InputItem.F,
            InputItem.G
          ], inputFunction, InputButtonStyle.quartenary(context), display:'a, b, c'),
          PadButton('list', InputButtonStyle.quartenary(context),(){
            showDialog(context: context,builder: (BuildContext context){
              return CatalogDialog(this.inputFunction);
            });
          }),
          PadButton('mode', InputButtonStyle.quartenary(context),(){
            showDialog(context: context,builder: (BuildContext context){
              return ModeDialog(this.options);
            });
          }),
          buildCommandButton(CommandItem.ENTER, InputButtonStyle.secondary(context)),
        ]
        ]
      )
    );
  }
}