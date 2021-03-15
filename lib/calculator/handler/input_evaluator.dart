import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:advanced_calculation/calculation_options.dart';
import 'package:advanced_calculation/syntax_exception.dart';
import 'package:open_calc/calculator/calculator_display/display_history.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/calculator/matrices/matrix_formatting.dart';

class InputEvaluator{
  final AdvancedCalculator calculator;
  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;
  InputEvaluator(this.storage, this.matrixStorage, [AdvancedCalculator calculator]):
      calculator = calculator ?? AdvancedCalculator();

  DisplayHistory evaluate(final List<InputItem> input, final List<DisplayHistory> history, final CalculationOptions options) {
    String resultString = '';
    List<InputItem> evaluatedInput = input;
    if(input.contains(InputItem.STORAGE)){
      resultString = _evaluateStorage(input, resultString, history, options);
    }else if(input.toString().contains("matr")){
      String translatedString = _translateMatrix(evaluatedInput);
      String returnedString = _calculateMatrix(translatedString);
      if(returnedString.contains("&")){
        MatrixFormatter format = new MatrixFormatter();
        resultString = "Results stored in matr" + (matrixStorage.length + 1).toString();
        matrixStorage.add(format.matrixStringToList(returnedString));
      }else{
        resultString = returnedString;
      }
    }else{
      if(input.isEmpty && history.isNotEmpty){
        evaluatedInput = history.last.evaluatedInput;
      }
      resultString = _calculate(evaluatedInput, history, options);
    }
    DisplayHistory newEntry = new DisplayHistory(input, resultString, evaluatedInput);

    return newEntry;
  }

  String _evaluateStorage(List<InputItem> input, String resultString, List<DisplayHistory> history, final CalculationOptions options) {
    InputItem variable = input.last;
    int stoIndex = input.indexOf(InputItem.STORAGE);
    if(variable.variable && stoIndex == input.length - 2){
      int stoIndex = input.indexOf(InputItem.STORAGE);
      List<InputItem> expression = input.sublist(0,stoIndex);
      resultString = _calculate(expression, history, options);
      storage.addVariable(variable.label, resultString);
    }else{
      throw new SyntaxException(stoIndex + 1);
    }
    return resultString;
  }

  String _calculate(final List<InputItem> input, final List<DisplayHistory> history, final CalculationOptions options){
    String inputString = _translateInput(input, history);
    String resultString = calculator.calculate(inputString, options);

    return resultString;
  }

  String _calculateMatrix(String input){
    
    String output = calculator.calculateMatrix(input);

    return output;
  }

  String _translateMatrix(final List<InputItem> input){
    
    String resultString = '';
    String inputString = input.toString();
    inputString = inputString.replaceAll("[", '');
    inputString = inputString.replaceAll("]", '');
    inputString = inputString.replaceAll(",", '');
    inputString = inputString.replaceAll(" ", '');
    inputString = inputString.replaceAll("matr", '');

    MatrixFormatter format = new MatrixFormatter();


    if(inputString.contains('—')){

      List<String> tokenizedString = inputString.split("—");
      int indexOne = int.parse(tokenizedString[0]) - 1;
      int indexTwo = int.parse(tokenizedString[1]) - 1;

      resultString = resultString + format.formatMatrixString(matrixStorage[indexOne]);
      resultString = resultString + "-";
      resultString = resultString + format.formatMatrixString(matrixStorage[indexTwo]);

    }else if(inputString.contains('+')){

      List<String> tokenizedString = inputString.split("+");
      int indexOne = int.parse(tokenizedString[0]) - 1;
      int indexTwo = int.parse(tokenizedString[1]) - 1;

      resultString = resultString + format.formatMatrixString(matrixStorage[indexOne]);
      resultString = resultString + "+";
      resultString = resultString + format.formatMatrixString(matrixStorage[indexTwo]);

    }else if(inputString.contains('x')){

      List<String> tokenizedString = inputString.split("x");
      int indexOne = int.parse(tokenizedString[0]) - 1;
      int indexTwo = int.parse(tokenizedString[1]) - 1;

      resultString = resultString + format.formatMatrixString(matrixStorage[indexOne]);
      resultString = resultString + "*";
      resultString = resultString + format.formatMatrixString(matrixStorage[indexTwo]);

    }else if(inputString.contains('÷')){

      List<String> tokenizedString = inputString.split("÷");
      int indexOne = int.parse(tokenizedString[0]) - 1;
      int indexTwo = int.parse(tokenizedString[1]) - 1;

      resultString = resultString + format.formatMatrixString(matrixStorage[indexOne]);
      resultString = resultString + "/";
      resultString = resultString + format.formatMatrixString(matrixStorage[indexTwo]);

    }else if(inputString.contains('detr')){
      
      String reducedString = inputString.replaceAll("detr", "");
      reducedString = reducedString.replaceAll(")", "");
      int index = int.parse(reducedString) - 1;
      resultString = "determinant(" + format.formatMatrixString(matrixStorage[index]) + ")";

    }else if(inputString.contains('perm')){

      String reducedString = inputString.replaceAll("perm", "");
      reducedString = reducedString.replaceAll(")", "");
      int index = int.parse(reducedString) - 1;
      resultString = "permanent(" + format.formatMatrixString(matrixStorage[index]) + ")";

    }else if(inputString.contains('tran')){

      String reducedString = inputString.replaceAll("tran", "");
      reducedString = reducedString.replaceAll(")", "");
      int index = int.parse(reducedString) - 1;
      resultString = "transpose(" + format.formatMatrixString(matrixStorage[index]) + ")";

    }else if(inputString.contains('inv')){

      String reducedString = inputString.replaceAll("inv", "");
      reducedString = reducedString.replaceAll(")", "");
      int index = int.parse(reducedString) - 1;
      resultString = "inverse(" + format.formatMatrixString(matrixStorage[index]) + ")";

    }else if(inputString.contains('rre')){

      String reducedString = inputString.replaceAll("rre", "");
      reducedString = reducedString.replaceAll(")", "");
      int index = int.parse(reducedString) - 1;
      resultString = "reduced_row_echelon(" + format.formatMatrixString(matrixStorage[index]) + ")";

    }

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