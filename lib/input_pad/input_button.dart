import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/input_pad/input_button_style.dart';

class InputButton extends StatelessWidget{
  final String text;
  final String value;
  final InputButtonStyle style;
  final Function(String text) onTap;

  InputButton(this.text, this.style, this.onTap, [String value]):
      this.value = value ?? text;

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
            child: Text(text, style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor)),
        ),
        onTap: (){
          this.onTap(this.value);
        },
      )),
    );
  }
}
