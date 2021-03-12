import 'package:advanced_calculation/syntax_exception.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/input_evaluator.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/settings/settings_controller.dart';

class CommandHandler{
  static const String SYNTAX_ERROR = 'Syntax Error';
  final CalculatorDisplayController controller;
  final VariableStorage storage;
  final InputEvaluator evaluator;
  final SettingsController settingsController;

  CommandHandler(this.controller, this.storage, this.settingsController, [InputEvaluator evaluator]):
      evaluator = evaluator ?? InputEvaluator(storage);

  void handle(CommandItem command) {
    if (command == CommandItem.ENTER) {
      try{
        DisplayHistory newEntry = evaluator.evaluate(controller.inputItems, controller.history, 
            settingsController.calculationOptions);
        controller.clearInput();
        controller.history.add(newEntry);
        settingsController.setCalcHistory(controller.history);
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