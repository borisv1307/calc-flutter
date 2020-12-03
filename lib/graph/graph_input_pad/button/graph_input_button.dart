import 'package:open_calc/graph/graph_input_pad/button/graph_pad_button.dart';
import 'package:open_calc/graph/graph_input_pad/graph_input_button_style.dart';
import 'package:open_calc/graph/graph_input_pad/graph_input_item.dart';

class InputButton extends PadButton{
  InputButton(InputItem inputItem, InputButtonStyle style, Function(InputItem value) onTap): super(inputItem.display, style, (){
    onTap(inputItem);
  });
}
