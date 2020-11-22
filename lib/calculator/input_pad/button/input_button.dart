import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class InputButton extends PadButton{
  InputButton(InputItem inputItem, InputButtonStyle style, Function(InputItem value) onTap): super(inputItem.display, style, (){
    onTap(inputItem);
  });
}
