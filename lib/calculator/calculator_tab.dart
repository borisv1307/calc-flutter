import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/handler/command_handler.dart';
import 'package:open_calc/calculator/handler/input_handler.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/settings/settings_controller.dart';

class CalculatorTab extends StatefulWidget {
  final VariableStorage storage;

  CalculatorTab(this.storage);
  @override
  State<StatefulWidget> createState() => CalculatorTabState(storage);
}

class CalculatorTabState extends State<CalculatorTab>{
  final VariableStorage storage;
  CalculatorDisplayController controller;
  InputHandler inputHandler;
  CommandHandler commandHandler;


  CalculatorTabState(this.storage) {
    controller = CalculatorDisplayController();
    inputHandler= InputHandler(controller);
  }

  @override
  Widget build(BuildContext context) {
    CalculationOptions options = SettingsController.of(context).calculationOptions;
    commandHandler = CommandHandler(controller, storage, options);
    return Container(
      color: Theme.of(context).colorScheme.background, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CalculatorDisplay(controller),
          ),
          Expanded(
            flex: 3,
            child: InputPad(options, storage, inputHandler.handle, commandHandler.handle)
          ),
        ],
      )
    );
  }
}
