import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/graph_input_pad/graph_command_item.dart';
import 'package:open_calc/graph/graph_input_pad/pad/graph_primary_pad.dart';
import 'package:open_calc/graph/graph_input_pad/pad/graph_secondary_pad.dart';
import 'package:open_calc/graph/graph_input_pad/button/graph_input_button.dart';
import 'package:open_calc/graph/graph_input_pad/button/graph_pad_button.dart';
import 'package:open_calc/graph/graph_input_pad/graph_input_button_style.dart';
import 'package:open_calc/graph/graph_input_pad/graph_input_item.dart';
import 'package:open_calc/graph/graph_input_pad/pad/graph_variable_screen.dart';


class InputPad extends StatelessWidget{

  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;
  final VariableStorage storage;

  InputPad(this.storage,this.inputFunction,this.commandFunction);


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
            builder = (BuildContext context) => PrimaryPad(this.storage,this.inputFunction, this.commandFunction);
            break;
          case 'inputPadTwo':
            builder = (BuildContext context) => SecondaryPad(this.storage,this.inputFunction, this.commandFunction);
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

