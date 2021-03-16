import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/pad/secondary_pad.dart';
import 'package:open_calc/calculator/input_pad/pad/variable_screen.dart';
import 'package:open_calc/graph/function_screen/input_pad/pad/graph_primary_pad.dart';

class GraphInputPad extends StatelessWidget{

  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;

  GraphInputPad(this.inputFunction, this.commandFunction);

  @override
  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: 'inputPadOne',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'inputPadOne':
            builder = (BuildContext context) => GraphPrimaryPad(this.inputFunction, this.commandFunction);
            break;
          case 'inputPadTwo':
            builder = (BuildContext context) => SecondaryPad(this.inputFunction, this.commandFunction, CalculationOptions());
            break;
          case 'varPad':
            builder = (BuildContext context) => VariableScreen(this.inputFunction);
            break;
        }
        return NoTransitionRoute(builder: builder, settings: settings);
      },
    );
  }
}

