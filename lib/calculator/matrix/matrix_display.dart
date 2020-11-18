import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';

class MatrixDisplay extends StatefulWidget{
  final List<List<String>> matrix;

  MatrixDisplay(this.matrix);
  @override
  State<StatefulWidget> createState() => MatrixDisplayState(matrix);
}

class MatrixDisplayState extends State<MatrixDisplay>{

  final List<List<String>> matrix;
  var editVal = '';

  MatrixDisplayState(this.matrix);

@override
Widget build(BuildContext context){

  return Container(
    alignment: Alignment.center,
    child: _buildMatrix(matrix),
  );
}

Widget _buildMatrix(List<List<String>> matrix) {

  int gridStateLength = matrix.length;
    return Column(
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
    Expanded(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(width: 2.0, color: Color(0xFF0000000)),
            right: BorderSide(width: 2.0, color: Color(0xFF0000000)),
        )),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: matrix[0].length,
          ),
          itemBuilder: (BuildContext context, int index) => _buildMatrixItems(context, index, matrix),
          itemCount: gridStateLength * matrix[0].length,
        ),
      ),
    ),
  ]);
}

Widget _buildMatrixItems(BuildContext context, int index, List<List<String>> matrix) {

  int gridStateLength = matrix[0].length;
  int x, y = 0;
  x = (index / gridStateLength).floor();
  y = (index % gridStateLength);
  return GestureDetector(
    onTap: () => setState(() { _matrixItemSelect(x, y, matrix); }),
    child: GridTile(
      child: Container(
        child: Center(
          child: _buildMatrixItem(x, y, matrix),
        ),
      ),
    ),
  );
}


  Widget _buildMatrixItem(int x, int y, List<List<String>> matrix) {
    return Text(matrix[x][y]);
  }

  Future _matrixItemSelect(int x, int y, List<List<String>> matrix) {

  TextEditingController _textFieldController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Number'),
            content: TextField(
              controller: _textFieldController,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "#"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  setState(() {
                    matrix[x][y] = _textFieldController.text;
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
    }
}
