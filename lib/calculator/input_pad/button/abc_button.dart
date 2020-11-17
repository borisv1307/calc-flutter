import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../input_button_style.dart';
import '../input_item.dart';

class AbcButton extends StatefulWidget {
  AbcButton(this.inputFunction, this.style);
  final Function(InputItem input) inputFunction;
  final InputButtonStyle style;
  State<StatefulWidget> createState() => _AbcButtonState();
}

class _AbcButtonState extends State<AbcButton> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child:Material(
        borderRadius: widget.style.radius,
        color: widget.style.backgroundColor,
        child:PopupMenuButton<InputItem>(
          child:InkWell(
            splashColor: Colors.blueGrey,
            borderRadius: widget.style.radius,
            child:Container(
              alignment: Alignment.center,
              child: Text("A,B,C", style: TextStyle(fontSize: widget.style.fontSize, fontWeight: widget.style.fontWeight, color: widget.style.textColor)),
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: InputItem.A,
              child: Text("A", style: TextStyle(fontSize: widget.style.fontSize, fontWeight: widget.style.fontWeight, color: widget.style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.B,
              child: Text("B", style: TextStyle(fontSize: widget.style.fontSize, fontWeight: widget.style.fontWeight, color: widget.style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.C,
              child: Text("C", style: TextStyle(fontSize: widget.style.fontSize, fontWeight: widget.style.fontWeight, color: widget.style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.D,
              child: Text("D", style: TextStyle(fontSize: widget.style.fontSize, fontWeight: widget.style.fontWeight, color: widget.style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.E,
              child: Text("E", style: TextStyle(fontSize: widget.style.fontSize, fontWeight: widget.style.fontWeight, color: widget.style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.F,
              child: Text("F", style: TextStyle(fontSize: widget.style.fontSize, fontWeight: widget.style.fontWeight, color: widget.style.textColor))
            ),
            PopupMenuItem(
              value: InputItem.G,
              child: Text("G", style: TextStyle(fontSize: widget.style.fontSize, fontWeight: widget.style.fontWeight, color: widget.style.textColor))
            ),
          ],
          initialValue: InputItem.A,
          onSelected: (value) {
            widget.inputFunction(value);
          }, 
        )
      )
    );
  }
}