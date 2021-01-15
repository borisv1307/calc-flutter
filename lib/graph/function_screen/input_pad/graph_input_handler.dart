import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class GraphInputHandler{
  final FunctionDisplayController controller;
  final VariableStorage storage;

  GraphInputHandler(this.controller, this.storage);

  void handleInput(InputItem inputItem) {
    controller.input(inputItem);
  }
  void handleCommand(CommandItem command) {
    if (command == CommandItem.ENTER) {
      // TODO: switch to graph screen
    } else if (command == CommandItem.DELETE) {
      controller.delete();
    } else if(command ==CommandItem.CLEAR) {
      controller.clearInput();
    }
  }

}