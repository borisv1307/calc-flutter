import 'package:open_calc/calculator/input_pad/input_item.dart';

class DisplayHistory{
  List<InputItem> input;
  List<InputItem> evaluatedInput;
  String result;

  DisplayHistory(this.input, this.result, [List<InputItem> evaluatedInput]):
      this.evaluatedInput = evaluatedInput ?? input;
  DisplayHistory.result(this.result);
}