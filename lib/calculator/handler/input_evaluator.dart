import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class InputEvaluator{
  final AdvancedCalculator calculator;
  InputEvaluator([AdvancedCalculator calculator]):
      calculator = calculator ?? AdvancedCalculator();

  DisplayHistory evaluate(final List<InputItem> input, final List<DisplayHistory> history) {
    String resultString = '';

    if (input.isNotEmpty) {
      String inputString = translateInput(input, history);
      resultString = calculator.calculate(inputString);
    } else if(history.isNotEmpty){
      resultString = history.last.result;
    }
    DisplayHistory newEntry = new DisplayHistory(input, resultString);

    return newEntry;
  }

  String translateInput(final List<InputItem> input, final List<DisplayHistory> history){
    String inputString = '';
    for(InputItem item in input){
      if(item == InputItem.ANSWER){
        inputString += history.last.result;
      }else{
        inputString += item.value;
      }
    }
    return inputString;
  }
}