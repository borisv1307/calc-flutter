import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class MultiButton extends PadButton {
  static const double HORIZONTAL_PADDING = 5;
  final List<InputItem> menuItems;
  MultiButton(this.menuItems, Function onTap, InputButtonStyle style, {String display}) : super(display, style, onTap){
    assert(this.menuItems.length <=4 || this.display != null);
  }

  Text _generateMultiText(String display){
    return Text(display, style: TextStyle(fontSize:15, fontWeight: style.fontWeight, color: style.textColor, height: 0.9), maxLines: 1);
  }


  Widget _buildFourLabel(final List<InputItem> displayItems){
    return Container(
        padding: EdgeInsets.symmetric(horizontal:HORIZONTAL_PADDING),
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _generateMultiText(displayItems[0].label)
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _generateMultiText(displayItems[1].label),
                _generateMultiText(displayItems[2].label)
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _generateMultiText(displayItems[3].label)
              ]
            )
          ],
        )
    );
  }

  Widget _buildTwoLabel(final List<InputItem> displayItems){
    return Container(
        padding: EdgeInsets.symmetric(horizontal:HORIZONTAL_PADDING),
        child:Column(
          children: [
            Row(
              children: [
                Text('', style: TextStyle(fontSize: 15, fontWeight: style.fontWeight, color: style.textColor, height: 0.9))
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _generateMultiText(displayItems[0].label),
                _generateMultiText(displayItems[1].label)
              ]
            ),
            Row(
              children: [
                Text('', style: TextStyle(fontSize: 15, fontWeight: style.fontWeight, color: style.textColor,height: 0.9))
              ]
            )
          ],
        )
    );
  }

  Widget _buildThreeLabel(final List<InputItem> displayItems){
    return Container(
        padding: EdgeInsets.symmetric(horizontal:HORIZONTAL_PADDING),
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _generateMultiText(displayItems[0].label)
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _generateMultiText(displayItems[1].label)
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _generateMultiText(displayItems[2].label)
              ]
            )
          ],
        )
    );
  }

  
  @override
  Widget build(BuildContext context) {

    Widget label;
    if(display == null){
      int numItems = menuItems.length;
      if(numItems == 2){
        label = _buildTwoLabel(menuItems);
      }else if(numItems == 3){
        label = _buildThreeLabel(menuItems);
      }else if(numItems == 4){
        label = _buildFourLabel(menuItems);
      }
    }else{
     label = Text(display, style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor));
    }


    return Container(
      margin: EdgeInsets.all(5),
      child:Material(
        borderRadius: style.radius,
        color: style.backgroundColor,
        child:PopupMenuButton<InputItem>(
          color: style.backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child:InkWell(
            splashColor: Colors.blueGrey,
            borderRadius: style.radius,
            child: Container(
              alignment: Alignment.center,
              child: label
            )
          ),
          itemBuilder: (context) => menuItems 
            .map((item) => PopupMenuItem<InputItem>(
              value: item,
              child: Container(
                alignment: Alignment.center,
                child: Text(item.label, style: TextStyle(fontSize: 20, fontWeight: style.fontWeight, color: style.textColor))
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