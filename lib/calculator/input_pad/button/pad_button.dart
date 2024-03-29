import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';

class PadButton extends StatelessWidget{
  final String display;
  final InputButtonStyle style;
  final Function onTap;
  final Function onHold;

  PadButton(this.display, this.style, this.onTap, {this.onHold});

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
              padding: this.style.padding,
              child: Text(this.display, style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor)),
            ),
            onTap: this.onTap,
            onLongPress: this.onHold
          )),
    );
  }
}