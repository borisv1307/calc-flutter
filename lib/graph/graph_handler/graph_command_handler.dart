import 'package:open_calc/graph/function_display_controller.dart';
import 'package:open_calc/graph/function_display_history.dart';
import 'package:open_calc/graph/graph_handler/graph_input_evaluator.dart';
import 'package:open_calc/graph/graph_input_pad/graph_command_item.dart';
import 'package:open_calc/graph/graph_input_pad/graph_input_variables.dart';

class CommandHandler{
  final FunctionDisplayController controller;
  final FunctionVariableStorage storage;
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