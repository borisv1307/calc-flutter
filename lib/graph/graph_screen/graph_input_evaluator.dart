import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/settings/settings_controller.dart';

class GraphInputEvaluator {
  GraphInputEvaluator();

  // takes a list of input strings and stringifies them, replacing variables
  List<String> translateInputs(List<List<InputItem>> inputs, SettingsController settings) {
    List<String> results = [];
    for (List<InputItem> input in inputs) {
      String inputString = '';
      for(InputItem item in input) {
        if (item.variable){
          inputString += settings.fetchVariable(item.value);
        } else{
          inputString += item.value;
        }
      }
      results.add(inputString);
      }
    return results;
  }
}
