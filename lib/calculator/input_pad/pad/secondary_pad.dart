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

  SecondaryPad(this.inputFunction, this.commandFunction);

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
          PadButton('Back', InputButtonStyle.SECONDARY, () {Navigator.pushReplacementNamed(context, 'inputPadOne');}),
          buildInputButton(InputItem.OPEN_PARENTHESIS, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.CLOSE_PARENTHESIS, InputButtonStyle.TERTIARY),
          buildCommandButton(CommandItem.DELETE,InputButtonStyle.TERTIARY),
          buildCommandButton(CommandItem.CLEAR,InputButtonStyle.TERTIARY),
        ],
        [
          MultiButton([InputItem.CSC, InputItem.SEC, InputItem.COT], inputFunction, InputButtonStyle.TERTIARY),
          MultiButton([InputItem.SINH, InputItem.COSH, InputItem.TANH], inputFunction, InputButtonStyle.TERTIARY),
          MultiButton([InputItem.ASIN, InputItem.ACOS, InputItem.ATAN], inputFunction, InputButtonStyle.TERTIARY),
          MultiButton([InputItem.ASINH, InputItem.ACOSH, InputItem.ATANH], inputFunction, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.DIVIDE, InputButtonStyle.SECONDARY),
        ],
        [
          buildInputButton(InputItem.SQUARE_ROOT, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.E_POWER_X, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.MULTIPLY, InputButtonStyle.SECONDARY),
        ],
        [
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          MultiButton([InputItem.DETERMINANT, InputItem.PERMANENT, InputItem.TRANSPOSE], inputFunction, InputButtonStyle.TERTIARY),
          MultiButton([InputItem.MATR_INVERSE, InputItem.REDUCED_ROW_ECHELON], inputFunction, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.SUBTRACT,  InputButtonStyle.SECONDARY),
        ],
        [
          buildInputButton(InputItem.COMMA, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          PadButton('Matr', InputButtonStyle.QUARTENARY, () {Navigator.pushNamed(context, 'matr');}),
          PadButton('Conv', InputButtonStyle.QUARTENARY, () {Navigator.of(context).pushNamed('conversions');}),
          buildInputButton(InputItem.ADD,  InputButtonStyle.SECONDARY),
        ],
        [
          PadButton('vars', InputButtonStyle.QUARTENARY, () {Navigator.pushReplacementNamed(context, 'varPad');}),
          MultiButton([
            InputItem.A,
            InputItem.B,
            InputItem.C,
            InputItem.D,
            InputItem.E,
            InputItem.F,
            InputItem.G
          ], inputFunction, InputButtonStyle.QUARTENARY, display:'a, b, c'),
          PadButton('list', InputButtonStyle.QUARTENARY,(){
            showDialog(context: context,builder: (BuildContext context){
              return CatalogDialog(this.inputFunction);
            });
          }),
          PadButton('mode', InputButtonStyle.QUARTENARY,(){
            showDialog(context: context,builder: (BuildContext context){
              return ModeDialog();
            });
          }),
          buildCommandButton(CommandItem.ENTER, InputButtonStyle.SECONDARY),
        ]
        ]
      )
    );
  }
}