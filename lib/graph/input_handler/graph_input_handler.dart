import 'package:open_calc/graph/graph_display_controller.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class InputHandler{
  final GraphDisplayController controller;

  InputHandler(this.controller);

  void handle(InputItem inputItem) {
    controller.input(inputItem);
  }
}