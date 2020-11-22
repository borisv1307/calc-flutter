import 'package:flutter/cupertino.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/handler/command_handler.dart';
import 'package:open_calc/calculator/handler/input_handler.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class CalculatorScreen extends StatefulWidget {
  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;

  CalculatorScreen(this.storage, this.matrixStorage);
  @override
  State<StatefulWidget> createState() => CalculatorScreenState(storage, matrixStorage);
}

class CalculatorScreenState extends State<CalculatorScreen>{

  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;

  CalculatorDisplayController controller;
  InputHandler inputHandler;
  CommandHandler commandHandler;

  CalculatorScreenState(this.storage, this.matrixStorage) {
    controller = CalculatorDisplayController();
    inputHandler= InputHandler(controller);
    commandHandler = CommandHandler(controller, storage, matrixStorage);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CalculatorDisplay(
            controller,
            numLines: 8
          ),
          Expanded(
            child: InputPad(storage, inputHandler.handle, commandHandler.handle, matrixStorage)
          ),
        ],
      )
    );
  }
}
