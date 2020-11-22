import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/input_evaluator.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class CommandHandler{
  final CalculatorDisplayController controller;
  final VariableStorage storage;
  final InputEvaluator evaluator;

  CommandHandler(this.controller, this.storage, [InputEvaluator evaluator]):
      evaluator = evaluator ?? InputEvaluator(storage);

  void handle(CommandItem command) {
    if (command == CommandItem.ENTER) {
      DisplayHistory newEntry = evaluator.evaluate(controller.inputItems, controller.history);
      controller.clearInput();
      controller.history.add(newEntry);
    } else if (command == CommandItem.DELETE) {
      controller.delete();
    } else if(command ==CommandItem.CLEAR) {
      controller.clearInput();
      controller.clearHistory();
    }
  }
}