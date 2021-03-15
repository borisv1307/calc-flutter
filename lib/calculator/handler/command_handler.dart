import 'package:advanced_calculation/angular_unit.dart';
import 'package:advanced_calculation/calculation_options.dart';
import 'package:advanced_calculation/syntax_exception.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/input_evaluator.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class CommandHandler{
  static const String SYNTAX_ERROR = 'Syntax Error';
  final CalculatorDisplayController controller;
  final VariableStorage storage;
  final InputEvaluator evaluator;
  final CalculationOptions options;
  final List<List<List<String>>> matrixStorage;

  CommandHandler(this.controller, this.storage, this.options, this.matrixStorage, [InputEvaluator evaluator]):
      evaluator = evaluator ?? InputEvaluator(storage, matrixStorage);

  void updateOptions(int decimals, AngularUnit unit) {
    this.options.decimalPlaces = decimals;
    this.options.angularUnit = unit;
  }

  void handle(CommandItem command) {
    if (command == CommandItem.ENTER) {
      try{
        DisplayHistory newEntry = evaluator.evaluate(controller.inputItems, controller.history,this.options);
        controller.clearInput();
        controller.history.add(newEntry);
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