import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/graph_screen/graph_input_evaluator.dart';


void main() {

  test('list of input strings is returned',() {
    GraphInputEvaluator evaluator = GraphInputEvaluator(VariableStorage());
    var inputList = [
      [InputItem.FIVE, InputItem.DIVIDE, InputItem.X],
      [InputItem.TWO, InputItem.X],
      [InputItem.LOG, InputItem.X, InputItem.CLOSE_PARENTHESIS]
    ];
    expect(evaluator.translateInputs(inputList), ["5/𝑥", "2𝑥", "log(𝑥)"]);
  });

  test('variables are translated',() {
    VariableStorage storage = VariableStorage();
    storage.addVariable("A", "123");
    GraphInputEvaluator evaluator = GraphInputEvaluator(storage);
    var inputList = [[InputItem.A, InputItem.ADD, InputItem.X]];
    expect(evaluator.translateInputs(inputList), ["123+𝑥"]);
  });

}
