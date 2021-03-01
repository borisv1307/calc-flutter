import 'package:flutter/material.dart';

class MatrDisplayWidget extends StatelessWidget{

  final List<List<String>> matrix;
  
  MatrDisplayWidget(this.matrix);

  Widget _buildDisplay(List<List<String>> matrix){

    int gridStateLength = matrix.length;
    
    return 
      Expanded(
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: matrix[0].length,
          ),
          itemBuilder: (BuildContext context, int index) => _buildMatrixCell(context, index, matrix),
          itemCount: gridStateLength * matrix[0].length,
        ),
    );
  }

  Widget _buildMatrixCell(BuildContext context, int index, List<List<String>> matrix) {

    int gridStateLength = matrix[0].length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);

    return GridTile(
        child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: _buildMatrixItem(x, y, matrix),
        ),
      )
    );
  }


  Widget _buildMatrixItem(int x, int y, List<List<String>> matrix) {
    return Text(matrix[x][y]);
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      alignment: Alignment.center,
      child: _buildDisplay(matrix)
    );
  }
}