import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/conversions/conversion_distance.dart';
import 'package:open_calc/calculator/conversions/conversion_weights.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/pad/primary_pad.dart';
import 'package:open_calc/calculator/input_pad/pad/secondary_pad.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/calculator/input_pad/pad/variable_screen.dart';
import 'package:open_calc/calculator/matrices/matrix_main.dart';


class InputPad extends StatelessWidget{

  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;
  final VariableStorage storage;
  final CalculationOptions options;
  final List<List<List<String>>> matrixStorage;

  InputPad(this.storage,this.inputFunction,this.commandFunction, this.options, this.matrixStorage);


  @override
  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: 'inputPadOne',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'inputPadOne':
            builder = (BuildContext context) => PrimaryPad(this.inputFunction, this.commandFunction);
            break;
          case 'inputPadTwo':
            builder = (BuildContext context) => SecondaryPad(this.inputFunction, this.commandFunction, this.options);
            break;
          case 'varPad':
            builder = (BuildContext context) => VariableScreen(this.inputFunction, this.storage);
            break;
          case 'matrPad' :
            builder = (BuildContext context) => MatrixHome(this.matrixStorage,this.inputFunction);
            break;
          case 'Weight' :
            builder = (BuildContext context) => WeightConvert();
            break;
          case 'Distance' :
            builder = (BuildContext context) => DistanceConvert();
            break;
        }
        return NoTransitionRoute(builder: builder, settings: settings);
      },
    );
  }
}


class NoTransitionRoute<T> extends MaterialPageRoute<T> {
  NoTransitionRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;  // route change without any transition
  }
}

