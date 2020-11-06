//import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:open_calc/bridge/graph_bridge.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
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

  String displayString = '';    // user input as it should be displayed on screen (raw): '𝑥²'
  String userInputString = '';  // user input as it should be stored for calculating:  'x ^ 2'
  GraphBridge bridge = GraphBridge();
  List<DisplayHistory> history = [];
  ValidateFunction tester = new ValidateFunction();

  // updates state to display new input on the calc screen
  void displayInput(String keypadInput, String keypadInputDisplay) {
    setState(() {
      displayString = (displayString + keypadInputDisplay);
      userInputString = (userInputString + keypadInput);
    });
  }

  // updates state to perform special button commands
  void executeCommand(String command, String display) {
    if (command == 'enter') {
      evaluate(userInputString, displayString);
    } else if (command =='del') {
      setState(() {
        userInputString = userInputString.substring(0,userInputString.length-1); // TODO: fix to delete tokens instead of characters
        displayString = displayString.substring(0,displayString.length-1);
      });
    }else if(command =='clear'){
      setState(() {
        userInputString = '';
        displayString = '';
        history=[];
      });
    }else if(command =='sto'){
      var toSto = userInputString.split('(');
      var keyNum = toSto[0];
      
      storage.addVariable(keyNum, toSto[1]);

      print(storage.variableMap);

      setState((){
        userInputString = '';
        displayString = '';
      });
    }
  }

  // evaluates a function and adds the input to the history
  void evaluate(String expression, String displayExpression) {
    print(userInputString);
    print(displayString);
    String resultString;
    if (expression?.isEmpty ?? true) {  // empty string or null
      resultString = (history.length == 0) ? "" : history.last.result;
    } else {
      bool validInput = tester.testFunction(expression);
      debugPrint("UI validation Check: $validInput");
      if (validInput) {
        double results = bridge.retrieveCalculatorResult(expression);  // call to backend evaluator
        resultString = results.toString(); 
      } else {
        resultString = "Syntax Error";
      }
    }
    DisplayHistory newEntry = new DisplayHistory(expression, displayExpression, resultString);
    setState(() {
      userInputString = '';
      displayString = '';
    });

    history.add(newEntry);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CalculatorDisplay(
            numLines: 8, 
            inputLine: displayString, 
            history: history
          ),
          Expanded(
            child: InputPad(storage, displayInput, executeCommand)
          ),
        ],
      )
    );
  }
}
