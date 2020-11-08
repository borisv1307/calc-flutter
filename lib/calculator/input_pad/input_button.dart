import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';

class InputButton extends StatelessWidget{
  final String buttonText;   // text on the button: '𝑥²'
  final String display;      // text to be displayed on screen: '²'
  final String value;        // text used for evaluation: '^ 2'
  final InputButtonStyle style;
  final Function(String value, String display) onTap;

  InputButton(this.buttonText, this.style, this.onTap, {String display, String value}):
      this.display = display ?? buttonText,
      this.value = value ?? buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child:Material(
        borderRadius: style.radius,
        color: style.backgroundColor,
        child:InkWell(
          splashColor: Colors.blueGrey,
          borderRadius: style.radius,
          child:Container(
            alignment: Alignment.center,
            child: Text(buttonText, style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor)),
        ),
        onTap: (){
          this.onTap(this.value, this.display);
        },
      )),
    );
  }
}
