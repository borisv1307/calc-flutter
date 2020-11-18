import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/matrix/matrix_display.dart';

class MatrixNavigator extends StatelessWidget{

  final List<List<List<String>>> matrixStorage;
  final List<String> matrixStringArray;

  MatrixNavigator(this.matrixStorage, this.matrixStringArray);

  Widget build(BuildContext context){
    return new Navigator(
      initialRoute: '',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case 'matrixHome' :
            builder = (BuildContext context) => MatrixHome(this.matrixStorage,this.matrixStringArray);
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
  final List<String> matrixStringArray;

  MatrixHome(this.matrixStorage, this.matrixStringArray);
  @override
  State<StatefulWidget> createState() => MatrixHomeState(matrixStorage, matrixStringArray);
}

class MatrixHomeState extends State<MatrixHome>{

  final List<List<List<String>>> matrixStorage;
  final List<String> matrixStringArray;

  MatrixHomeState(this.matrixStorage, this.matrixStringArray);
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
        MatrixAccessor((i+1).toString(), matrixStorage[i], InputButtonStyle.TERTIARY, this.matrixStringArray)
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
  final List<String> matrixStringArray;

  MatrixAccessor(this.number, this.matrix, this.style, this.matrixStringArray);

  String printMatrix(List<List<String>> matrix){

    String formattedMatrix = '';

    for(int i=0; i < (matrix.length); i++){

      String startString = "| ";
      formattedMatrix = formattedMatrix + startString;

      for(int a=0; a < (matrix[0].length); a++){
        String toAdd = matrix[i][a] + " ";
        formattedMatrix = formattedMatrix + toAdd;
      }

      String endString = "|\n";
      formattedMatrix = formattedMatrix + endString;
    }

    return formattedMatrix;
  }

  String formatMatrixString(List<List<String>> matrix){

    String formattedMatrix = '';

    for(int i=0; i < (matrix.length ); i++){
      for(int a=0; a < (matrix[0].length); a++){
        String toAdd = '';
        toAdd = matrix[i][a];
        if(a < (matrix[0].length-1)){
          toAdd = toAdd + ",";
        }
        formattedMatrix = formattedMatrix + toAdd;
      }
      if(i < (matrix.length-1)){
        formattedMatrix = formattedMatrix + "!";
      }
    }

    return formattedMatrix;
  }

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
          if(matrixStringArray.length < 3){
            var formatted = formatMatrixString(matrix);
            matrixStringArray.add(formatted);
          }else{
            print("no more than two");
          }
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