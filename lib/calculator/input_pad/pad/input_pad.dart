import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/pad/input_pad_one.dart';
import 'package:open_calc/calculator/input_pad/pad/input_pad_two.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/calculator/input_pad/pad/variable_screen.dart';


class InputPad extends StatelessWidget{

  final Function(InputItem input) inputFunction;
  final Function(String command) commandFunction;
  final VariableStorage storage;

  InputPad(this.storage,this.inputFunction,this.commandFunction);


  Widget buildInputButton(InputItem inputItem, InputButtonStyle type){
    return InputButton(inputItem, type, inputFunction);
  }

  Widget buildCommandButton(String text, InputButtonStyle type){
    return PadButton(text, type, (){
      commandFunction(text);
    });
  }

  @override
  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: 'inputPadOne',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'inputPadOne':
            builder = (BuildContext context) => InputPadOne(this.storage,this.inputFunction, this.commandFunction);
            break;
          case 'inputPadTwo':
            builder = (BuildContext context) => InputPadTwo(this.storage,this.inputFunction, this.commandFunction);
            break;
          case 'varPad':
            builder = (BuildContext context) => VariableScreen(this.storage,this.inputFunction, this.commandFunction);
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

