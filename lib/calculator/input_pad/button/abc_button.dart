import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import '../input_button_style.dart';
import '../input_item.dart';

class AbcButton extends PadButton {

  AbcButton(Function onTap, InputButtonStyle style) 
    : super("A,B,C", style, onTap);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child:Material(
        borderRadius: style.radius,
        color: style.backgroundColor,
        child:PopupMenuButton<InputItem>(
          child:InkWell(
            splashColor: Colors.blueGrey,
            borderRadius: style.radius,
            child:Container(
              alignment: Alignment.center,
              child: Text(display, style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor)),
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: InputItem.A,
              child: Text("A", style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.B,
              child: Text("B", style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.C,
              child: Text("C", style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.D,
              child: Text("D", style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.E,
              child: Text("E", style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.F,
              child: Text("F", style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.G,
              child: Text("G", style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor))
            ),
          ],
          initialValue: InputItem.A,
          onSelected: (value) {
            onTap(value);
          }, 
        )
      )
    );
  }
}