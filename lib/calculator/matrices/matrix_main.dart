import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/matrices/matrix_display.dart';

class MatrixNavigator extends StatelessWidget{

  final List<List<List<String>>> matrixStorage;
  final Function(InputItem input) inputFunction;

  MatrixNavigator(this.matrixStorage, this.inputFunction);

  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: '',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'matrixHome' :
            builder = (BuildContext context) => MatrixHome(this.matrixStorage, this.inputFunction);
            break;
          case 'matrixCreate' :
            builder = (BuildContext context) => MatrixCreate(this.matrixStorage);
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
       },
      );
  }
}

class MatrixHome extends StatefulWidget{

  final List<List<List<String>>> matrixStorage;
  final Function(InputItem input) inputFunction;

  MatrixHome(this.matrixStorage, this.inputFunction);
  @override
  State<StatefulWidget> createState() => MatrixHomeState(matrixStorage, inputFunction);
}

class MatrixHomeState extends State<MatrixHome>{

  final List<List<List<String>>> matrixStorage;
  final Function(InputItem input) inputFunction;

  MatrixHomeState(this.matrixStorage, this.inputFunction);
//--------------Add new Matrix Dialogs--------------------------------------
  Future _collectColsRows() {

  TextEditingController _textFieldController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Rows/Cols'),
            content: 
            TextField(
              controller: _textFieldController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "#"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  var arr = _textFieldController.text.split("-");
                  var newList = List.generate(int.parse(arr[0]), (index) => List.generate(int.parse(arr[1]), (index2) => "_"));
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

    int i = 0;
    for(i=0; i < matrixStorage.length; i++){
      matrixAccessorWidgets.add(
        MatrixAccessor((i+1).toString(), matrixStorage[i], InputButtonStyle.TERTIARY, this.inputFunction)
      );
    }

    return matrixAccessorWidgets;
  }

  Widget build(BuildContext context) {
    return Column(children:[
      Container(
      color:Colors.black38,
      alignment: Alignment.center,
      child:ListView(
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
                  
                },
              )),
            ),
          
          ListView(
            shrinkWrap: true,
            children: [
            for(var item in _getMatrixList(matrixStorage)) Container(child: item)
          ],),

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
    )]);
  }
}

class MatrixAccessor extends StatelessWidget{

  final String number;
  final List<List<String>> matrix;
  final InputButtonStyle style;
  final Function(InputItem input) inputFunction;

  MatrixAccessor(this.number, this.matrix, this.style, this.inputFunction);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child:Material(
        borderRadius: style.radius,
        color: style.backgroundColor,
        child:InkWell(
          splashColor: Colors.blueGrey,
          borderRadius: style.radius,
          child:Container(
            alignment: Alignment.center,
            child: Text('Matrix: ' + number, style: TextStyle(fontSize: style.fontSize, fontWeight: style.fontWeight, color: style.textColor)),
        ),
        onLongPress: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MatrixDisplay(matrix)));
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