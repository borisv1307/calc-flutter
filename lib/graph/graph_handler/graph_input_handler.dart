import 'package:open_calc/graph/function_display_controller.dart';
import 'package:open_calc/graph/graph_input_pad/graph_input_item.dart';

class InputHandler{
  final FunctionDisplayController controller;

  InputHandler(this.controller);

  void handle(InputItem inputItem) {
    if(inputItem.lookback && controller.history.isNotEmpty && controller.inputItems.isEmpty){
      controller.input(InputItem.ANSWER);
    }
    controller.input(inputItem);
  }
}