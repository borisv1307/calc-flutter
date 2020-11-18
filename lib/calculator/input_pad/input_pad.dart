import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/button/input_button.dart';
import 'package:open_calc/calculator/input_pad/button/pad_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/calculator/matrix/matrix_main.dart';

class InputPad extends StatelessWidget{

  final Function(InputItem input) inputFunction;
  final Function(String command) commandFunction;
  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;
  final List<String> matrixMathList;

  InputPad(this.storage,this.inputFunction,this.commandFunction, this.matrixStorage, this.matrixMathList);


  Widget _buildInputButton(InputItem inputItem, InputButtonStyle type){
    return InputButton(inputItem, type, inputFunction);
  }

  Widget _buildCommandButton(String text, InputButtonStyle type){
    return PadButton(text, type, (){
      commandFunction(text);
    });
  }

  //====================================================================================
  //==================================================================================

  @override
  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: 'inputPadOne',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'inputPadOne':
            builder = (BuildContext context) => InputPadOne(this.storage,this.inputFunction, this.commandFunction,this.matrixStorage,this.matrixMathList);
            break;
          case 'inputPadTwo':
            builder = (BuildContext context) => InputPadTwo(this.storage,this.inputFunction, this.commandFunction,this.matrixStorage,this.matrixMathList);
            break;
          case 'varPad':
            builder = (BuildContext context) => VariableScreen(this.storage,this.inputFunction, this.commandFunction,this.matrixStorage,this.matrixMathList);
            break;
          case 'Matr':
            builder = (BuildContext context) => MatrixHome(matrixStorage, matrixMathList);
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class InputPadOne extends InputPad{

  InputPadOne(storage,input,command,matrixStorage,matrixMathList) : super(storage,input,command,matrixStorage,matrixMathList);
  
  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    double availableHeight = MediaQuery.of(context).size.height;
    return Container(
        color:Colors.black38,
        alignment: Alignment.center,
        child:GridView.count(
          shrinkWrap: true,
          crossAxisCount: 5,
          childAspectRatio: availableWidth/availableHeight,
          physics: NeverScrollableScrollPhysics(),
          children:[
            Container(
              margin: EdgeInsets.all(5),
              child:Material(
                borderRadius: InputButtonStyle.SECONDARY.radius,
                color: InputButtonStyle.SECONDARY.backgroundColor,
                child:InkWell(
                  splashColor: Colors.blueGrey,
                  borderRadius: InputButtonStyle.SECONDARY.radius,
                  child:Container(
                    alignment: Alignment.center,
                    child: Text('Alt', style: TextStyle(fontSize: InputButtonStyle.SECONDARY.fontSize, fontWeight: InputButtonStyle.SECONDARY.fontWeight, color: InputButtonStyle.SECONDARY.textColor)),
                ),
                onTap: (){
                   Navigator.of(context).pushReplacementNamed('inputPadTwo');
                },
              )),
            ),
            _buildInputButton(InputItem.SIN, InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.COS, InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.TAN, InputButtonStyle.TERTIARY),
            _buildCommandButton('del',InputButtonStyle.TERTIARY),
            _buildCommandButton('clear',InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.SQUARED, InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.OPEN_PARENTHESIS, InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.CLOSE_PARENTHESIS, InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.DIVIDE, InputButtonStyle.SECONDARY),
            _buildInputButton(InputItem.POWER, InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.SEVEN, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.EIGHT, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.NINE, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.MULTIPLY, InputButtonStyle.SECONDARY),
            _buildInputButton(InputItem.LOG, InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.FOUR, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.FIVE, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.SIX, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.SUBTRACT, InputButtonStyle.SECONDARY),
            _buildInputButton(InputItem.NATURAL_LOG, InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.ONE, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.TWO, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.THREE, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.ADD, InputButtonStyle.SECONDARY),
            _buildCommandButton('sto', InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.ZERO, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.DECIMAL, InputButtonStyle.PRIMARY),
            _buildInputButton(InputItem.NEGATIVE, InputButtonStyle.PRIMARY),
            _buildCommandButton('enter', InputButtonStyle.SECONDARY),
              ],

        ));
    }
}

class InputPadTwo extends InputPad{

  InputPadTwo(storage,input,command,matrixStorage,matrixMathList) : super(storage,input,command,matrixStorage,matrixMathList);

  @override
  Widget build(BuildContext context) {
    double availableWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    double availableHeight = MediaQuery.of(context).size.height;
    return Container(
        color:Colors.black38,
        alignment: Alignment.center,
        child:GridView.count(
          shrinkWrap: true,
          crossAxisCount: 5,
          childAspectRatio: availableWidth/availableHeight,
          physics: NeverScrollableScrollPhysics(),
          children:[
            Container(
              margin: EdgeInsets.all(5),
              child:Material(
                borderRadius: InputButtonStyle.SECONDARY.radius,
                color: InputButtonStyle.SECONDARY.backgroundColor,
                child:InkWell(
                  splashColor: Colors.blueGrey,
                  borderRadius: InputButtonStyle.SECONDARY.radius,
                  child:Container(
                    alignment: Alignment.center,
                    child: Text('Back', style: TextStyle(fontSize: InputButtonStyle.SECONDARY.fontSize, fontWeight: InputButtonStyle.SECONDARY.fontWeight, color: InputButtonStyle.SECONDARY.textColor)),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('inputPadOne');
                },
              )),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child:Material(
                borderRadius: InputButtonStyle.SECONDARY.radius,
                color: InputButtonStyle.SECONDARY.backgroundColor,
                child:InkWell(
                  splashColor: Colors.blueGrey,
                  borderRadius: InputButtonStyle.SECONDARY.radius,
                  child:Container(
                    alignment: Alignment.center,
                    child: Text('Vars', style: TextStyle(fontSize: InputButtonStyle.SECONDARY.fontSize, fontWeight: InputButtonStyle.SECONDARY.fontWeight, color: InputButtonStyle.SECONDARY.textColor)),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('varPad');
                },
              )),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child:Material(
                borderRadius: InputButtonStyle.SECONDARY.radius,
                color: InputButtonStyle.SECONDARY.backgroundColor,
                child:InkWell(
                  splashColor: Colors.blueGrey,
                  borderRadius: InputButtonStyle.SECONDARY.radius,
                  child:Container(
                    alignment: Alignment.center,
                    child: Text('Matr', style: TextStyle(fontSize: InputButtonStyle.SECONDARY.fontSize, fontWeight: InputButtonStyle.SECONDARY.fontWeight, color: InputButtonStyle.SECONDARY.textColor)),
                ),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('Matr');
                },
              )),
            ),
            _buildInputButton(InputItem.A,InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.B,InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.C,InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.D,InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.E,InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.F,InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.G,InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.H,InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.I,InputButtonStyle.TERTIARY),
            _buildInputButton(InputItem.J,InputButtonStyle.TERTIARY),


              ],

        ));
    }
}


class VariableScreen extends InputPad{

  VariableScreen(storage,input,command,matrixStorage,matrixMathList) : super(storage,input,command,matrixStorage,matrixMathList);

  List<Widget> _getVariables(){
    var list = [];
    var keyList = [];
    storage.variableMap.forEach((k,v) => list.add(v));
    storage.variableMap.forEach((k,v) => keyList.add(k));
    List variablesWidgets = List<Widget>();
    int i = 0;
    for(i=0; i < list.length; i++){
      variablesWidgets.add(
        _buildInputButton(InputItem(keyList[i] + ': ' + list[i], value: list[i]), InputButtonStyle.TERTIARY) ///TODO update to not be input button
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
                borderRadius: InputButtonStyle.SECONDARY.radius,
                color: InputButtonStyle.SECONDARY.backgroundColor,
                child:InkWell(
                  splashColor: Colors.blueGrey,
                  borderRadius: InputButtonStyle.SECONDARY.radius,
                  child:Container(
                    alignment: Alignment.center,
                    child: Text('Back', style: TextStyle(fontSize: InputButtonStyle.SECONDARY.fontSize, fontWeight: InputButtonStyle.SECONDARY.fontWeight, color: InputButtonStyle.SECONDARY.textColor)),
                ),
                onTap: (){
                   Navigator.of(context).pushReplacementNamed('inputPadTwo');
                },
              )),     
          ),
      for(var item in _getVariables()) Container(child: item)
    ]
    );
  }
}