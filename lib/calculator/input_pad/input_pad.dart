import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';

class InputPad extends StatelessWidget{

  final Function(String text) input;
  final Function(String command) command;

  InputPad(this.input,this.command);

  Widget _buildInputButton(String text, InputButtonStyle type, {String value}){
    return InputButton(text, type, input, value);
  }

  Widget _buildCommandButton(String text, InputButtonStyle type, {String value}){
    return InputButton(text, type, command, value);
  }

  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    double availableHeight = MediaQuery.of(context).size.height;
    return Container(
        color:Colors.black38,
        alignment: Alignment.bottomCenter,
        child:GridView.count(
          shrinkWrap: true,
          crossAxisCount: 5,
          childAspectRatio: availableWidth/availableHeight,
          physics: NeverScrollableScrollPhysics(),
          children:[
            _buildInputButton('sin',InputButtonStyle.TERTIARY,value:'sin('),
            _buildInputButton('cos',InputButtonStyle.TERTIARY,value:'cos('),
            _buildInputButton('tan',InputButtonStyle.TERTIARY,value:'tan('),
            _buildCommandButton('del',InputButtonStyle.TERTIARY),
            _buildCommandButton('clear',InputButtonStyle.TERTIARY),
            _buildInputButton('𝑥 ⁻¹',InputButtonStyle.TERTIARY, value:'⁻¹'),
            _buildInputButton('𝑥 ²',InputButtonStyle.TERTIARY, value:'²'),
            _buildInputButton('(',InputButtonStyle.TERTIARY),
            _buildInputButton(')',InputButtonStyle.TERTIARY),
            _buildInputButton('÷',InputButtonStyle.SECONDARY,value:'/'),
            _buildInputButton('^',InputButtonStyle.TERTIARY),
            _buildInputButton('7',InputButtonStyle.PRIMARY),
            _buildInputButton('8',InputButtonStyle.PRIMARY),
            _buildInputButton('9',InputButtonStyle.PRIMARY),
            _buildInputButton('x',InputButtonStyle.SECONDARY, value: '*'),
            _buildInputButton('log',InputButtonStyle.TERTIARY,value:'log('),
            _buildInputButton('4',InputButtonStyle.PRIMARY),
            _buildInputButton('5',InputButtonStyle.PRIMARY),
            _buildInputButton('6',InputButtonStyle.PRIMARY),
            _buildInputButton('-',InputButtonStyle.SECONDARY, value:' - '),
            _buildInputButton('ln',InputButtonStyle.TERTIARY,value:'ln('),
            _buildInputButton('1',InputButtonStyle.PRIMARY),
            _buildInputButton('2',InputButtonStyle.PRIMARY),
            _buildInputButton('3',InputButtonStyle.PRIMARY),
            _buildInputButton('+',InputButtonStyle.SECONDARY, value: ' + '),
            _buildInputButton(',',InputButtonStyle.TERTIARY),
            _buildInputButton('0',InputButtonStyle.PRIMARY),
            _buildInputButton('.',InputButtonStyle.PRIMARY),
            _buildInputButton('−',InputButtonStyle.PRIMARY,value:'-'),
            _buildCommandButton('enter',InputButtonStyle.SECONDARY),
              ],

        ));
  }

}
