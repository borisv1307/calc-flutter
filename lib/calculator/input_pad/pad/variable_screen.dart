
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class VariableScreen extends InputPad{

  VariableScreen(storage,input, command) : super(storage,input, command);

  List<Widget> _getVariables(){
    var list = [];
    var keyList = [];
    storage.variableMap.forEach((k,v) => list.add(v));
    storage.variableMap.forEach((k,v) => keyList.add(k));
    List variablesWidgets = List<Widget>();
    int i = 0;
    for(i=0; i < list.length; i++){
      variablesWidgets.add(
        buildInputButton(InputItem(keyList[i] + ': ' + list[i], value: list[i]), InputButtonStyle.QUARTENARY) ///TODO update to not be input button
      );
    }
    for( ; i < 29; i++){
      variablesWidgets.add(
        buildInputButton(InputItem.EMPTY, InputButtonStyle.QUARTENARY)
      );
    }
    return variablesWidgets;
  }
  
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    double availableHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      child:GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        childAspectRatio: availableWidth/availableHeight,
        physics: NeverScrollableScrollPhysics(),
        children: [
          PadButton('Back', InputButtonStyle.SECONDARY, () {Navigator.pushReplacementNamed(context, 'inputPadTwo');}),
          for(var item in _getVariables()) Container(child: item)
        ]
      )
    );
  }
}