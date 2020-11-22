import 'package:open_calc/calculator/input_pad/input_item.dart';

class DisplayHistory{
  List<InputItem> input;
  String result;

  DisplayHistory(this.input, this.result);
  DisplayHistory.result(this.result);
}