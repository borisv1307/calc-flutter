import 'package:flutter/cupertino.dart';
import 'package:open_calc/bridge/graph_bridge.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/calculator/input_validation/validate_function.dart';

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
  CalculatorDisplayController calculatorDisplayController = CalculatorDisplayController();

  // updates state to display new input on the calc screen
  void displayInput(String keypadInput) {
    calculatorDisplayController.inputLine = (calculatorDisplayController.inputLine + keypadInput);
  }

  // updates state to perform special button commands
  void executeCommand(String command) {
    if (command == 'enter') {
      evaluate(calculatorDisplayController.inputLine);
    } else if (command =='del') {
      calculatorDisplayController.inputLine = calculatorDisplayController.inputLine.substring(0,calculatorDisplayController.inputLine.length-1);
    }else if(command =='clear'){
      calculatorDisplayController.inputLine = '';
      calculatorDisplayController.history=[];
    }else if(command =='sto'){
      var toSto = calculatorDisplayController.inputLine.split('(');
      var keyNum = toSto[0];
      
      storage.addVariable(keyNum, toSto[1]);

      print(storage.variableMap);

      calculatorDisplayController.inputLine = '';
    }
  }

  // evaluates a function and adds the input to the history
  void evaluate(String expression) {
    String resultString;
    print(expression);
    if (expression?.isEmpty ?? true) {  // empty string or null
      resultString = (calculatorDisplayController.history.length == 0) ? "" : calculatorDisplayController.history.last.result;
    } else if (tester.testFunction(expression)) {
      double results = bridge.retrieveCalculatorResult(expression);  // call to backend evaluator
      resultString = results.toString(); 
    } else {
      resultString = "Syntax Error";
    }
    DisplayHistory newEntry = new DisplayHistory(expression, resultString);
    calculatorDisplayController.inputLine = '';

    calculatorDisplayController.history.add(newEntry);

  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CalculatorDisplay(calculatorDisplayController,
            numLines: 8, 
          ),
          Expanded(
            child: InputPad(storage, displayInput, executeCommand)
          ),
        ],
      )
    );
  }
}
