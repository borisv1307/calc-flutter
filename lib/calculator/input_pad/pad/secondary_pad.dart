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
          buildCommandButton(CommandItem.DELETE,InputButtonStyle.TERTIARY),
          buildCommandButton(CommandItem.CLEAR,InputButtonStyle.TERTIARY),
          MultiButton([InputItem.CSC, InputItem.SEC, InputItem.COT], inputFunction, InputButtonStyle.TERTIARY),
          MultiButton([InputItem.SINH, InputItem.COSH, InputItem.TANH], inputFunction, InputButtonStyle.TERTIARY),
          MultiButton([InputItem.ASIN, InputItem.ACOS, InputItem.ATAN], inputFunction, InputButtonStyle.TERTIARY),
          MultiButton([InputItem.ASINH, InputItem.ACOSH, InputItem.ATANH], inputFunction, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.DIVIDE, InputButtonStyle.SECONDARY),
          buildInputButton(InputItem.E_POWER_X, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.MULTIPLY, InputButtonStyle.SECONDARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.SUBTRACT,  InputButtonStyle.SECONDARY),
          buildInputButton(InputItem.COMMA, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.EMPTY, InputButtonStyle.TERTIARY),
          buildInputButton(InputItem.ADD,  InputButtonStyle.SECONDARY),
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
          buildInputButton(InputItem.EMPTY, InputButtonStyle.QUARTENARY),
          buildCommandButton(CommandItem.ENTER, InputButtonStyle.SECONDARY),
        ],
      )
    );
  }
}