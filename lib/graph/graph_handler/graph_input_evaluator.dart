import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:open_calc/graph/function_display_history.dart';
import 'package:open_calc/graph/graph_input_pad/graph_input_item.dart';
import 'package:open_calc/graph/graph_input_pad/graph_input_variables.dart';

class InputEvaluator{
  static const String SYNTAX_ERROR = 'Syntax Error';

  final AdvancedCalculator calculator;
  final FunctionVariableStorage storage;
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
      resultString = SYNTAX_ERROR;
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
        bool replaceableItemAfterNonLookback = !prior.lookback && item.replaceable;
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