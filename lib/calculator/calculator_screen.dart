import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class CalculatorScreen extends StatefulWidget {
  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;
  final List<String> matrixMathList;

  CalculatorScreen(this.storage, this.matrixStorage, this.matrixMathList);
  @override
  State<StatefulWidget> createState() => CalculatorScreenState(storage, matrixStorage, matrixMathList);
}

class CalculatorScreenState extends State<CalculatorScreen>{

  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;
    final List<String> matrixMathList;
  CalculatorScreenState(this.storage,this.matrixStorage,this.matrixMathList);
  CalculatorDisplayController controller = CalculatorDisplayController();
  AdvancedCalculator advancedCalculator = AdvancedCalculator();

  // updates state to display new input on the calc screen
  void _displayInput(InputItem keypadInput) {
      controller.input(keypadInput);
  }


  // updates state to perform special pad_button commands
  void _executeCommand(String command) {
    if (command == 'enter') {
      _evaluate(controller.inputLine, controller.inputItems);
    } else if (command =='del') {
      controller.delete();
    } else if(command =='clear') {
      controller.clearInput();
      controller.history=[];
    } else if(command =='sto') {
      var toSto = controller.inputLine.split('(');
      var keyNum = toSto[0];
      storage.addVariable(keyNum, toSto[1]);
      print(storage.variableMap);
      controller.clearInput();
    }
  }

  // evaluates a function and adds the input to the history
  void _evaluate(String displayExpression, List<InputItem> input) {

    String resultString;

    if (displayExpression?.isEmpty ?? true) {  // empty string or null
      resultString = (controller.history.length == 0) ? "" : controller.history.last.result;
    } else {
      resultString = advancedCalculator.calculate(displayExpression);
    }
    DisplayHistory newEntry = new DisplayHistory(input, resultString);
    controller.clearInput();

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
            child: InputPad(storage, _displayInput, _executeCommand,matrixStorage,matrixMathList)
          ),
        ],
      )
    );
  }
}
