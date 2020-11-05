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

  String userInputString = '';
  GraphBridge bridge = GraphBridge();
  List<DisplayHistory> history = [];
  ValidateFunction tester = new ValidateFunction();

  // updates state to display new input on the calc screen
  void displayInput(String keypadInput) {
    setState(() {
      userInputString = (userInputString + keypadInput);
    });
  }

  // updates state to perform special button commands
  void executeCommand(String command) {
    if (command == 'enter') {
      evaluate(userInputString);
    } else if (command =='del') {
      setState(() {
        userInputString = userInputString.substring(0,userInputString.length-1);
      });
    }else if(command =='clear'){
      setState(() {
        userInputString = '';
        history=[];
      });
    }else if(command =='sto'){
      var toSto = userInputString.split('(');
      var keyNum = toSto[0];
      
      storage.addVariable(keyNum, toSto[1]);

      print(storage.variableMap);

      setState((){
        userInputString = '';
      });
    }
  }

  // evaluates a function and adds the input to the history
  void evaluate(String expression) {
    String resultString;
    print(expression);
    if (expression?.isEmpty ?? true) {  // empty string or null
      resultString = (history.length == 0) ? "" : history.last.result;
    } else if (tester.testFunction(expression)) {
      double results = bridge.retrieveCalculatorResult(expression);  // call to backend evaluator
      resultString = results.toString(); 
    } else {
      resultString = "Syntax Error";
    }
    DisplayHistory newEntry = new DisplayHistory(expression, resultString);
    setState(() {
      userInputString = '';
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
            inputLine: userInputString, 
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
