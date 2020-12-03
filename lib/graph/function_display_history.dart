import 'package:open_calc/graph/graph_input_pad/graph_input_item.dart';

class DisplayHistory{
  List<InputItem> input;
  String result;

  DisplayHistory(this.input, this.result);
  DisplayHistory.result(this.result);
}