import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:advanced_calculation/syntax_exception.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/settings/settings_controller.dart';

class InputEvaluator{
  final AdvancedCalculator calculator;
  final SettingsController settingsController;
  InputEvaluator(this.settingsController, [AdvancedCalculator calculator]):
      calculator = calculator ?? AdvancedCalculator();

  DisplayHistory evaluate(final List<InputItem> input, final List<DisplayHistory> history) {
    String resultString = '';
    List<InputItem> evaluatedInput = input;
    if(input.contains(InputItem.STORAGE)){
      resultString = _evaluateStorage(input, resultString, history);
    }else{
      if(input.isEmpty && history.isNotEmpty){
        evaluatedInput = history.last.evaluatedInput;
      }
      resultString = _calculate(evaluatedInput, history);
    }
    DisplayHistory newEntry = new DisplayHistory(input, resultString, evaluatedInput);

    return newEntry;
  }

  String _evaluateStorage(List<InputItem> input, String resultString, List<DisplayHistory> history) {
    InputItem variable = input.last;
    int stoIndex = input.indexOf(InputItem.STORAGE);
    if(variable.variable && stoIndex == input.length - 2){
      int stoIndex = input.indexOf(InputItem.STORAGE);
      List<InputItem> expression = input.sublist(0,stoIndex);
      resultString = _calculate(expression, history);
      settingsController.storeVariable(variable.label, resultString);
    }else{
      throw new SyntaxException(stoIndex + 1);
    }
    return resultString;
  }

  String _calculate(final List<InputItem> input, final List<DisplayHistory> history){
    String inputString = _translateInput(input, history);
    String resultString = calculator.calculate(inputString, settingsController.calculationOptions);

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
        inputString += (history.last.result[0] == '-')
          ? history.last.result.replaceFirst('-', '`')
          : history.last.result;
      } else if (item.variable){
        inputString += (settingsController.fetchVariable(item.value)[0] == '-')
          ? settingsController.fetchVariable(item.value).replaceFirst('-', '`')
          : settingsController.fetchVariable(item.value);
      } else{
        inputString += item.value;
      }
      prior = item;
    }
    return inputString;
  }
}