import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class InputHandler{
  final FunctionDisplayController controller;

  InputHandler(this.controller);

  void handle(InputItem inputItem) {
    controller.input(inputItem);
  }
}