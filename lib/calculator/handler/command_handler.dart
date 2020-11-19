import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/input_evaluator.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class CommandHandler{
  final CalculatorDisplayController controller;
  final VariableStorage storage;
  final InputEvaluator evaluator;

  CommandHandler(this.controller, this.storage, [InputEvaluator evaluator]):
      evaluator = evaluator ?? InputEvaluator();

  void handle(String command) {
    if (command == 'enter') {
      DisplayHistory newEntry = evaluator.evaluate(controller.inputItems, controller.history);
      controller.clearInput();
      controller.history.add(newEntry);
    } else if (command =='del') {
      controller.delete();
    } else if(command =='clear') {
      controller.clearInput();
      controller.clearHistory();
    } else if(command =='sto') {
      var toSto = controller.inputLine.split('(');
      var keyNum = toSto[0];
      storage.addVariable(keyNum, toSto[1]);
      print(storage.variableMap);
      controller.clearInput();
    }
  }
}