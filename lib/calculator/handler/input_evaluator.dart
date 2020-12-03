import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/handler/syntax_exception.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class InputEvaluator{
    final AdvancedCalculator calculator;
  final VariableStorage storage;
  InputEvaluator(this.storage, [AdvancedCalculator calculator]):
      calculator = calculator ?? AdvancedCalculator();

  DisplayHistory evaluate(final List<InputItem> input, final List<DisplayHistory> history) {
    String resultString = '';

    if(input.contains(InputItem.STORAGE)){
      resultString = _evaluateStorage(input, resultString, history);
    }else if (input.isNotEmpty) {
      resultString = _calculate(input, history);
    } else if(history.isNotEmpty){
      resultString = history.last.result;
    }
    DisplayHistory newEntry = new DisplayHistory(input, resultString);

    return newEntry;
  }

  String _evaluateStorage(List<InputItem> input, String resultString, List<DisplayHistory> history) {
    InputItem variable = input.last;
    int stoIndex = input.indexOf(InputItem.STORAGE);
    if(variable.variable && stoIndex == input.length - 2){
      int stoIndex = input.indexOf(InputItem.STORAGE);
      List<InputItem> expression = input.sublist(0,stoIndex);
      resultString = _calculate(expression, history);
      storage.addVariable(variable.display, resultString);
    }else{
      throw new SyntaxException(stoIndex + 1);
    }
    return resultString;
  }

  String _calculate(final List<InputItem> input, final List<DisplayHistory> history){
    String inputString = _translateInput(input, history);
    String resultString = calculator.calculate(inputString);

    return resultString;
  }

  String _translateInput(final List<InputItem> input, final List<DisplayHistory> history){
    String inputString = '';
    InputItem prior;
    for(InputItem item in input) {
      if(prior != null){
        bool nonLookbackAfterReplaceableItem = !item.lookback && prior.replaceable;
        bool replaceableItemAfterNonLookback = !prior.lookback && item.replaceable && !prior.function;
        if(nonLookbackAfterReplaceableItem || replaceableItemAfterNonLookback){
          inputString += InputItem.MULTIPLY.value;
        }
      }

      if (item == InputItem.ANSWER) {
        inputString += history.last.result;
      } else if (item.variable){
        inputString += storage.fetchVariable(item.value);
      } else{
        inputString += item.value;
      }
      prior = item;
    }
    return inputString;
  }
}