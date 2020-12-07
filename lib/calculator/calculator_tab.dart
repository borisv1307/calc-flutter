import 'package:flutter/cupertino.dart';
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

  CalculatorTabState(this.storage) {
    controller = CalculatorDisplayController();
    inputHandler= InputHandler(controller);
    commandHandler = CommandHandler(controller, storage);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CalculatorDisplay(
            controller,
            numLines: 10
          ),
          Expanded(
            child: InputPad(storage, inputHandler.handle, commandHandler.handle)
          ),
        ],
      )
    );
  }
}
