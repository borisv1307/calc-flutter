import 'dart:math';

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

  void setLabelInput(String keypadInput) {
    setState(() {
      userInputString = (userInputString + keypadInput);
    });
  }

  void executeCommand(String command){
    if(command == 'enter'){
      collectInput(userInputString);
    }else if(command =='del'){
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

  //evaluates a function and adds the input to the history
  void collectInput(String expression) {
    String results;
    if(expression != null || expression.isNotEmpty) {
      if (tester.testFunction(expression)) {
        results = bridge.retrieveCalculatorResult(
            expression); // call to backend evaluator
      } else {
        results = "Syntax Error";
      }
    }else {
      results = "Syntax Error";
    }
    DisplayHistory newEntry = new DisplayHistory(expression, results);
    setState(() {
      userInputString = '';
    });

    history.add(newEntry);

  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CalculatorDisplay(8,inputLine:userInputString,history:history),
              Expanded(child:InputPad(storage,setLabelInput,executeCommand)),
            ],)
    );
  }
}
