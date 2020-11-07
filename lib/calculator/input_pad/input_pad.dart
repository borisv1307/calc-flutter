import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_button.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class InputPad extends StatelessWidget{

  final Function(String input, String displayInput) input;
  final Function(String command, String displayCommand) command;
  final VariableStorage storage;

  InputPad(this.storage,this.input,this.command);


  Widget _buildInputButton(String text, InputButtonStyle type, {String display, String value}){
    return InputButton(text, type, input, 
      display: display, 
      value: value
    );
  }

  Widget _buildCommandButton(String text, InputButtonStyle type, {String value}){
    return InputButton(text, type, command,
      display: '',
      value: value
    );
  }

  @override
  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: 'inputPadOne',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'inputPadOne':
            builder = (BuildContext context) => InputPadOne(this.storage,this.input, this.command);
            break;
          case 'inputPadTwo':
            builder = (BuildContext context) => InputPadTwo(this.storage,this.input, this.command);
            break;
          case 'varPad':
            builder = (BuildContext context) => VariableScreen(this.storage,this.input, this.command);
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
            _buildInputButton('sin', InputButtonStyle.TERTIARY, display:'sin(', value:'sin ( '),
            _buildInputButton('cos', InputButtonStyle.TERTIARY, display:'cos(', value:'cos ( '),
            _buildInputButton('tan', InputButtonStyle.TERTIARY, display:'tan(', value:'tan ( '),
            _buildCommandButton('del',InputButtonStyle.TERTIARY),
            _buildCommandButton('clear',InputButtonStyle.TERTIARY),
            _buildInputButton('𝑥 ²', InputButtonStyle.TERTIARY, display:'²', value: ' ^ 2 '),
            _buildInputButton('(', InputButtonStyle.TERTIARY, value: ' ( '),
            _buildInputButton(')', InputButtonStyle.TERTIARY, value: ' ) '),
            _buildInputButton('÷', InputButtonStyle.SECONDARY, display: ' / ', value: ' / '),
            _buildInputButton('^', InputButtonStyle.TERTIARY, value: '^ '),
            _buildInputButton('7', InputButtonStyle.PRIMARY, value: '7'),
            _buildInputButton('8', InputButtonStyle.PRIMARY, value: '8'),
            _buildInputButton('9', InputButtonStyle.PRIMARY, value: '9'),
            _buildInputButton('x', InputButtonStyle.SECONDARY, display: ' * ', value: ' * '),
            _buildInputButton('log', InputButtonStyle.TERTIARY, display: 'log(', value: ' log ( '),
            _buildInputButton('4', InputButtonStyle.PRIMARY, value: '4'),
            _buildInputButton('5', InputButtonStyle.PRIMARY, value: '5'),
            _buildInputButton('6', InputButtonStyle.PRIMARY, value: '6'),
            _buildInputButton('−', InputButtonStyle.SECONDARY, display: ' − ', value: ' - '),
            _buildInputButton('ln', InputButtonStyle.TERTIARY, display: 'ln(', value: 'ln ( '),
            _buildInputButton('1', InputButtonStyle.PRIMARY, value: '1'),
            _buildInputButton('2', InputButtonStyle.PRIMARY, value: '2'),
            _buildInputButton('3', InputButtonStyle.PRIMARY, value: '3'),
            _buildInputButton('+', InputButtonStyle.SECONDARY, display: ' + ', value: ' + '),
            _buildCommandButton('sto', InputButtonStyle.TERTIARY),
            _buildInputButton('0', InputButtonStyle.PRIMARY, value: '0'),
            _buildInputButton('.', InputButtonStyle.PRIMARY),
            _buildInputButton('(-)', InputButtonStyle.PRIMARY,display: '-', value: '-'),
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