import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/calculator/input_pad/input_button_style.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/matrices/matrix_pad/matrix_pad.dart';

class MatrixDisplay extends StatefulWidget{
  final List<List<String>> matrix;

  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;

  MatrixDisplay(this.matrix, this.inputFunction, this.commandFunction);
  @override
  State<StatefulWidget> createState() => MatrixDisplayState(matrix, this.inputFunction, this.commandFunction);
}

class MatrixDisplayState extends State<MatrixDisplay>{

  final List<List<String>> matrix;
  var editVal = '';
  final Function(InputItem input) inputFunction;
  final Function(CommandItem command) commandFunction;

  MatrixDisplayState(this.matrix, this.inputFunction, this.commandFunction);

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
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
        ),
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

  CalculatorDisplayController controller = CalculatorDisplayController();

    return showDialog(
      context: context,
      builder: (BuildContext context){

        return StatefulBuilder(
          builder: (context, setState){
          return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: 
            SizedBox(
              height: 530,
            child: 
            Container(
              color: Colors.black38, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child:
                    CalculatorDisplay(controller)
                  ),
                  Expanded(
                    child:
                    MatrixInputPad(controller, matrix, x, y, context)
                  )
          ]))
        ));});
      }
    );
  }
}