import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class InputPad extends StatelessWidget{

  final Function(String input) inputFunction;
  final Function(String command) commandFunction;
  final VariableStorage storage;

  InputPad(this.storage,this.inputFunction,this.commandFunction);


  Widget _buildInputButton(String text, InputButtonStyle type, {String display, String value}){
    return InputButton(text, type, inputFunction, 
      value: display, 
    );
  }

  Widget _buildCommandButton(String text, InputButtonStyle type){
    return InputButton(text, type, commandFunction);
  }

  @override
  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: 'inputPadOne',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'inputPadOne':
            builder = (BuildContext context) => InputPadOne(this.storage,this.inputFunction, this.commandFunction);
            break;
          case 'inputPadTwo':
            builder = (BuildContext context) => InputPadTwo(this.storage,this.inputFunction, this.commandFunction);
            break;
          case 'varPad':
            builder = (BuildContext context) => VariableScreen(this.storage,this.inputFunction, this.commandFunction);
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class InputPadOne extends InputPad{

  InputPadOne(storage,input, command) : super(storage,input, command);
  
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
            _buildInputButton('sin', InputButtonStyle.TERTIARY, display:'sin('),
            _buildInputButton('cos', InputButtonStyle.TERTIARY, display:'cos('),
            _buildInputButton('tan', InputButtonStyle.TERTIARY, display:'tan('),
            _buildCommandButton('del',InputButtonStyle.TERTIARY),
            _buildCommandButton('clear',InputButtonStyle.TERTIARY),
            _buildInputButton('𝑥 ²', InputButtonStyle.TERTIARY, display:'²'),
            _buildInputButton('(', InputButtonStyle.TERTIARY),
            _buildInputButton(')', InputButtonStyle.TERTIARY),
            _buildInputButton('÷', InputButtonStyle.SECONDARY, display: ' / '),
            _buildInputButton('^', InputButtonStyle.TERTIARY),
            _buildInputButton('7', InputButtonStyle.PRIMARY),
            _buildInputButton('8', InputButtonStyle.PRIMARY),
            _buildInputButton('9', InputButtonStyle.PRIMARY),
            _buildInputButton('x', InputButtonStyle.SECONDARY, display: ' * '),
            _buildInputButton('log', InputButtonStyle.TERTIARY, display: 'log('),
            _buildInputButton('4', InputButtonStyle.PRIMARY),
            _buildInputButton('5', InputButtonStyle.PRIMARY),
            _buildInputButton('6', InputButtonStyle.PRIMARY),
            _buildInputButton('−', InputButtonStyle.SECONDARY, display: ' − '),
            _buildInputButton('ln', InputButtonStyle.TERTIARY, display: 'ln('),
            _buildInputButton('1', InputButtonStyle.PRIMARY),
            _buildInputButton('2', InputButtonStyle.PRIMARY),
            _buildInputButton('3', InputButtonStyle.PRIMARY),
            _buildInputButton('+', InputButtonStyle.SECONDARY, display: ' + '),
            _buildCommandButton('sto', InputButtonStyle.TERTIARY),
            _buildInputButton('0', InputButtonStyle.PRIMARY),
            _buildInputButton('.', InputButtonStyle.PRIMARY),
            _buildInputButton('(-)', InputButtonStyle.PRIMARY,display: '-'),
            _buildCommandButton('enter', InputButtonStyle.SECONDARY),
              ],

        ));
    }
}

class InputPadTwo extends InputPad{

  InputPadTwo(storage,input, command) : super(storage,input, command);

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
            _buildInputButton('A',InputButtonStyle.TERTIARY,value:'A'),
            _buildInputButton('B',InputButtonStyle.TERTIARY,value:'B'),
            _buildInputButton('C',InputButtonStyle.TERTIARY,value:'C'),
            _buildInputButton('D',InputButtonStyle.TERTIARY,value:'D'),
            _buildInputButton('E',InputButtonStyle.TERTIARY,value:'E'),
            _buildInputButton('F',InputButtonStyle.TERTIARY,value:'F'),
            _buildInputButton('G',InputButtonStyle.TERTIARY,value:'G'),
            _buildInputButton('H',InputButtonStyle.TERTIARY,value:'H'),
            _buildInputButton('I',InputButtonStyle.TERTIARY,value:'I'),
            _buildInputButton('J',InputButtonStyle.TERTIARY,value:'J'),

              ],

        ));
    }
}


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
        _buildInputButton(keyList[i] + ': ' + list[i], InputButtonStyle.TERTIARY, value: list[i])
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