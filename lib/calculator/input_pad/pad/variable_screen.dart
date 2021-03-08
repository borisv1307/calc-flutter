import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

import '../input_variables.dart';

class VariableScreen extends StatelessWidget{

  final Function(InputItem input) inputFunction;
  final VariableStorage storage;

  VariableScreen(this.inputFunction, this.storage);



  List<Widget> _getVariables(InputButtonStyle style){
    var list = [];
    var keyList = [];
    storage.variableMap.forEach((k,v) => list.add(v));
    storage.variableMap.forEach((k,v) => keyList.add(k));
    List variablesWidgets = [];
    int i = 0;
    for(i=0; i < list.length; i++){
      variablesWidgets.add(
        InputButton(InputItem(keyList[i] + ': ' + list[i], display: list[i]), style, inputFunction) ///TODO update to not be input button
      );
    }

    return variablesWidgets;
  }
  
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    double availableHeight = MediaQuery.of(context).size.height;
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        childAspectRatio: availableWidth/availableHeight,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
              margin: EdgeInsets.all(5),
              child:Material(
                borderRadius: InputButtonStyle.secondary(context).radius,
                color: InputButtonStyle.secondary(context).backgroundColor,
                child:InkWell(
                  splashColor: Colors.blueGrey,
                  borderRadius: InputButtonStyle.secondary(context).radius,
                  child:Container(
                    alignment: Alignment.center,
                    child: Text('Back', style: TextStyle(fontSize: InputButtonStyle.secondary(context).fontSize, fontWeight: InputButtonStyle.secondary(context).fontWeight, color: InputButtonStyle.secondary(context).textColor)),
                ),
                onTap: (){
                   Navigator.pushReplacementNamed(context, 'inputPadTwo');
                },
              )),     
          ),
      for(var item in _getVariables(InputButtonStyle.tertiary(context))) Container(child: item)
    ]
    );
  }
}