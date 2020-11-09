//import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:open_calc/bridge/graph_bridge.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/calculator/input_validation/validate_function.dart';
import 'package:open_calc/calculator/translator/translator.dart';

class CalculatorScreen extends StatefulWidget {
  final VariableStorage storage;

  CalculatorScreen(this.storage);
  @override
  State<StatefulWidget> createState() => CalculatorScreenState(storage);
}

class CalculatorScreenState extends State<CalculatorScreen>{

  final VariableStorage storage;
  CalculatorScreenState(this.storage);

  GraphBridge bridge = GraphBridge();
  ValidateFunction tester = new ValidateFunction();
  Translator translator = new Translator();
  CalculatorDisplayController controller = CalculatorDisplayController();

  // updates state to display new input on the calc screen
  void displayInput(String keypadInput) {
      controller.input(keypadInput);
  }

  // updates state to perform special button commands
  void executeCommand(String command) {
    if (command == 'enter') {
      evaluate(controller.inputLine);
    } else if (command =='del') {
      controller.delete();
    } else if(command =='clear') {
      controller.inputLine = '';
      controller.history=[];
    } else if(command =='sto') {
      var toSto = controller.inputLine.split('(');
      var keyNum = toSto[0];
      storage.addVariable(keyNum, toSto[1]);
      print(storage.variableMap);
      controller.inputLine = '';
    }
  }

  // evaluates a function and adds the input to the history
  void evaluate(String displayExpression) {
    String resultString;

    // convert display string to proper math format
    String expression = translator.translate(displayExpression);

    if (expression?.isEmpty ?? true) {  // empty string or null
      resultString = (controller.history.length == 0) ? "" : controller.history.last.result;
    } else {
      bool validInput = tester.testFunction(expression);
      if (validInput) {
        double results = bridge.retrieveCalculatorResult(expression);  // call to backend evaluator
        resultString = results.toString(); 
      } else {
        resultString = "Syntax Error";
      }
    }
    DisplayHistory newEntry = new DisplayHistory(displayExpression, resultString);
    controller.inputLine = '';

    controller.history.add(newEntry);
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
            child: InputPad(storage, displayInput, executeCommand)
          ),
        ],
      )
    );
  }
}
