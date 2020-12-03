import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/graph_display_controller.dart';
import 'package:open_calc/graph/graph_handler/graph_input_evaluator.dart';
import 'package:open_calc/graph/graph_input_pad/graph_command_item.dart';

class CommandHandler{
  final GraphDisplayController controller;
  final VariableStorage storage;
  final InputEvaluator evaluator;

  CommandHandler(this.controller, this.storage, [InputEvaluator evaluator]):
      evaluator = evaluator ?? InputEvaluator(storage);

  void handle(CommandItem command) {
    if (command == CommandItem.ENTER) {
      // evaluator.evaluate(controller.inputItems, controller.history);
    } else if (command == CommandItem.DELETE) {
      controller.delete();
    } else if(command ==CommandItem.CLEAR) {
      controller.clearInput();
    }
  }
}