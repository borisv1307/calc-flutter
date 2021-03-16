import 'package:flutter_test/flutter_test.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:open_calc/graph/graph_screen/graph_input_evaluator.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  group('input evaluator',() {
    SettingsController settings;

    setUp(() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      settings = SettingsController(pref);
    });

    test('list of input strings is returned',() {
      GraphInputEvaluator evaluator = GraphInputEvaluator();
      var inputList = [
        [InputItem.FIVE, InputItem.DIVIDE, InputItem.X],
        [InputItem.TWO, InputItem.X],
        [InputItem.LOG, InputItem.X, InputItem.CLOSE_PARENTHESIS]
      ];
      expect(evaluator.translateInputs(inputList, settings), ["5/𝑥", "2𝑥", "log(𝑥)"]);
    });

    test('variables are translated',() {
      settings.storeVariable("A", "123");
      GraphInputEvaluator evaluator = GraphInputEvaluator();
      var inputList = [[InputItem.A, InputItem.ADD, InputItem.X]];
      expect(evaluator.translateInputs(inputList, settings), ["123+𝑥"]);
    });
  });
}
