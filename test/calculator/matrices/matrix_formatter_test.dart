import 'package:open_calc/calculator/matrices/matrix_formatting.dart';
import 'package:test/test.dart';

void main(){
  
  String testMatrixString = "1;2;3!1;2;3!1;2;3";
  List<List<String>> testMatrixList = [['1','2','3'],['1','2','3'],['1','2','3']];
  MatrixFormatter format = new MatrixFormatter();
  String printTest = "| 1 2 3 |\n| 1 2 3 |\n| 1 2 3 |\n";
  group('matrix formatting', (){

    test('format string from list',(){

      var result = format.formatMatrixString(testMatrixList);
      expect(result, testMatrixString);
    });

    test('pretty print matrix from list', (){
      
      var result = format.printMatrix(testMatrixList);
      expect(result, printTest);
    });

    test('format list from string', (){
      
      var result = format.matrixStringToList(testMatrixString);
      expect(result, testMatrixList);
    });
  });
}