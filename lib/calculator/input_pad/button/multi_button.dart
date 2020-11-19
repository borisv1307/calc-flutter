import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class MultiButton extends PadButton {

  final List<InputItem> menuItems;
  MultiButton(String display, Function onTap, InputButtonStyle style, this.menuItems) 
    : super(display, style, onTap);
  
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
          itemBuilder: (context) => menuItems 
            .map((item) => PopupMenuItem<InputItem>(
              value: item,
              child: Center(
                child: Text(item.display, style: TextStyle(fontSize: 20, fontWeight: style.fontWeight, color: style.textColor))
              )
            )).toList(),
          onSelected: (value) {
            onTap(value);
          }, 
        )
      )
    );
  }
}