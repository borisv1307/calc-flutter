import 'package:flutter/foundation.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class DisplayHistory{
  List<InputItem> input;
  List<InputItem> evaluatedInput;
  String result;

  DisplayHistory(this.input, this.result, [List<InputItem> evaluatedInput]):
      this.evaluatedInput = evaluatedInput ?? input;
  DisplayHistory.result(this.result);

  DisplayHistory.fromJson(Map<String, dynamic> json) :
    this.input = json['input'].map<InputItem>((jsonItem) => InputItem.fromJson(jsonItem)).toList(),
    this.evaluatedInput = json['evaluatedInput'].map<InputItem>((jsonItem) => InputItem.fromJson(jsonItem)).toList(),
    this.result = json['result'];

  Map<String, dynamic> toJson() {
    List<Map> jsonInputItems = [];
    List<Map> jsonEvaluatedInputItems = [];
    for (InputItem item in input) {
      jsonInputItems.add(item.toJson());
    }
    for (InputItem item in evaluatedInput) {
      jsonEvaluatedInputItems.add(item.toJson());
    }
    return {
      'input': jsonInputItems,
      'evaluatedInput': jsonEvaluatedInputItems,
      'result': result
    };
  }

  // override comparison for testing
  bool operator ==(o) => 
    o is DisplayHistory &&
    listEquals(o.input, input) &&
    listEquals(o.evaluatedInput, evaluatedInput) &&
    o.result == result;

  int get hashCode => input.hashCode ^ evaluatedInput.hashCode ^ result.hashCode;


}