import 'package:advanced_calculation/syntax_exception.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';


class MatrixCommandHandler{
  static const String SYNTAX_ERROR = 'Syntax Error';
  final CalculatorDisplayController controller;
  final List<List<String>> matrix;
  final int xIndex;
  final int yIndex;
  final BuildContext context;


  MatrixCommandHandler(this.controller, this.matrix, this.xIndex, this.yIndex, this.context);

  void handle(CommandItem command) {
    if (command == CommandItem.ENTER) {
      try{
        matrix[xIndex][yIndex] = controller.inputLine;
        Navigator.pop(context);
      } on SyntaxException catch(e){
        controller.cursorIndex = e.index;
        controller.pushAlert(SYNTAX_ERROR);
      }
    } else if (command == CommandItem.DELETE) {
      controller.delete();
    } else if(command ==CommandItem.CLEAR) {
      controller.clearInput();
      controller.clearHistory();
    }
  }
}