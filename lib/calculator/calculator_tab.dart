import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/handler/command_handler.dart';
import 'package:open_calc/calculator/handler/input_handler.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

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
  CalculationOptions options;

  CalculatorTabState(this.storage) {
    controller = CalculatorDisplayController();
    options = CalculationOptions();
    inputHandler= InputHandler(controller);
    commandHandler = CommandHandler(controller, storage,options);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CalculatorDisplay(
                controller,
            ),
          ),
          Expanded(
            flex: 3,
            child: InputPad(storage, inputHandler.handle, commandHandler.handle, options)
          ),
        ],
      )
    );
  }
}
