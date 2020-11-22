import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class InputHandler{
  final CalculatorDisplayController controller;

  InputHandler(this.controller);

  void handle(InputItem inputItem) {
    if(inputItem.lookback && controller.history.isNotEmpty && controller.inputItems.isEmpty){
      controller.input(InputItem.ANSWER);
    }
    controller.input(inputItem);
  }
}