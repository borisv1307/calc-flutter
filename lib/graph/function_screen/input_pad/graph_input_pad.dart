import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/pad/secondary_pad.dart';
import 'package:open_calc/calculator/input_pad/pad/variable_screen.dart';
import 'package:open_calc/graph/function_screen/input_pad/pad/graph_primary_pad.dart';

class GraphInputPad extends InputPad{

  GraphInputPad(storage, inputFunction, commandFunction) : super(storage, inputFunction, commandFunction);

  @override
  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: 'inputPadOne',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'inputPadOne':
            builder = (BuildContext context) => GraphPrimaryPad(this.storage,this.inputFunction, this.commandFunction);
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

