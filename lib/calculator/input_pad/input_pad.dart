import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/pad/primary_pad.dart';
import 'package:open_calc/calculator/input_pad/pad/secondary_pad.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/calculator/input_pad/pad/variable_screen.dart';
import 'package:open_calc/calculator/matrices/matrix_main.dart';


class InputPad extends StatelessWidget{

  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;
  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;

  InputPad(this.storage,this.inputFunction,this.commandFunction,this.matrixStorage);


  Widget buildInputButton(InputItem inputItem, InputButtonStyle type){
    return InputButton(inputItem, type, inputFunction);
  }

  Widget buildCommandButton(CommandItem commandItem, InputButtonStyle type){
    return PadButton(commandItem.display, type, (){
      commandFunction(commandItem);
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
            builder = (BuildContext context) => PrimaryPad(this.storage,this.inputFunction,this.commandFunction,this.matrixStorage);
            break;
          case 'inputPadTwo':
            builder = (BuildContext context) => SecondaryPad(this.storage,this.inputFunction,this.commandFunction,this.matrixStorage);
            break;
          case 'varPad':
            builder = (BuildContext context) => VariableScreen(this.storage,this.inputFunction,this.commandFunction,this.matrixStorage);
            break;
          case 'matrPad' :
            builder = (BuildContext context) => MatrixHome(this.matrixStorage,this.inputFunction);
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

