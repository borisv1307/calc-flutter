import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/calculator/matrices/matrix_display.dart';
import 'package:open_calc/calculator/matrices/matrix_formatting.dart';

import 'matrix_pad/matrix_display_widget.dart';

class MatrixHome extends StatefulWidget{

  final List<List<List<String>>> matrixStorage;
  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;
  final VariableStorage storage;

  MatrixHome(this.matrixStorage, this.inputFunction, this.commandFunction, this.storage);
  @override
  State<StatefulWidget> createState() => MatrixHomeState(matrixStorage, inputFunction, commandFunction, storage);
}

class MatrixHomeState extends State<MatrixHome>{

  final List<List<List<String>>> matrixStorage;
  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;
  final VariableStorage storage;

  MatrixHomeState(this.matrixStorage, this.inputFunction, this.commandFunction, this.storage);
//--------------Add new Matrix Dialogs--------------------------------------

  void _refresh(){
    setState((){});
  }

  Future _collectColsRows() {

  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Rows/Cols'),
            content:
            Column(children: [
            TextField(
              controller: _textFieldController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Rows"),
            ),
            TextField(
              controller: _textFieldController2,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Cols"),
            )],),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  //var arr = _textFieldController.text.split("-");
                  var newList = List.generate(int.parse(_textFieldController.text), (index) => List.generate(int.parse(_textFieldController2.text), (index2) => "_"));
                  setState(() {
                    matrixStorage.add(newList);
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    }

//--------------------------------------------------------------------------------------------
  List<Widget> _getMatrixList(List<List<List<String>>> matrixStorage){

    List matrixAccessorWidgets = List<Widget>();
    MatrixFormatter format = new MatrixFormatter();

    int i = 0;
    for(i=0; i < matrixStorage.length; i++){
      matrixAccessorWidgets.add(
        MatrixAccessor((i+1).toString(), matrixStorage[i], InputButtonStyle.TERTIARY, this.inputFunction, format, commandFunction, storage, matrixStorage, _refresh)
      );
    }

    return matrixAccessorWidgets;
  }

  Widget build(BuildContext context) {
    return 
      Column(children:[
      Expanded(child:
      Container(
      color:Colors.black38,
      alignment: Alignment.center,
      child:
      ListView(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        children: <Widget>[
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
                    child: Text('Add New Matrix', style: TextStyle(fontSize: InputButtonStyle.SECONDARY.fontSize, fontWeight: InputButtonStyle.SECONDARY.fontWeight, color: InputButtonStyle.SECONDARY.textColor)),
                ),
                onTap: (){
                  _collectColsRows();
                  _getMatrixList(matrixStorage);
                  
                },
              )),
            ),

          Expanded(child: 
          ListView(
            shrinkWrap: true,
            children: [
            for(var item in _getMatrixList(matrixStorage)) Container(child: item)
          ],)),

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
        ]
      )
    ))]);
  }
}

class MatrixAccessor extends StatelessWidget{

  final String number;
  final List<List<String>> matrix;
  final InputButtonStyle style;
  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;
  final MatrixFormatter format;
  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;
  final Function refresh;

  MatrixAccessor(this.number, this.matrix, this.style, this.inputFunction, this.format, this.commandFunction, this.storage, this.matrixStorage, this.refresh);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child:Material(
        borderRadius: style.radius,
        color: style.backgroundColor,
        child:InkWell(
          splashColor: Colors.blueGrey,
          borderRadius: style.radius,
          child:Container(
            alignment: Alignment.center,
            child: Column(children:[Text("Matrix " + number, style: TextStyle(fontSize: InputButtonStyle.SECONDARY.fontSize, fontWeight: InputButtonStyle.SECONDARY.fontWeight, color: InputButtonStyle.SECONDARY.textColor)), 
            SizedBox(width: 350, height: 100, child:MatrDisplayWidget(matrix))]),
        ),
        onLongPress: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MatrixDisplay(matrix, inputFunction, commandFunction, refresh)));
        },
        onTap: (){
          inputFunction(InputItem('matr' + number));
        },
      )),
    );
  }

}

class MatrixCreate extends StatefulWidget{

   final List<List<List<String>>> matrixStorage;

  MatrixCreate(this.matrixStorage);

  State<StatefulWidget> createState() => MatrixCreateState(matrixStorage);

}

class MatrixCreateState extends State<MatrixCreate> {

  final List<List<List<String>>> matrixStorage;

  MatrixCreateState(this.matrixStorage);

  String currentSelected;

  Widget build(BuildContext context){
  return(
     Column(
      children: <Widget>[
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
              Navigator.of(context).pop();
              
            },
          )),
      ),
      ]));
  }
}