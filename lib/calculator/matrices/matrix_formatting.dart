
class MatrixFormatter{

String formatMatrixString(List<List<String>> matrix){

  String formattedMatrix = '&';

    for(int i=0; i < (matrix.length ); i++){
      for(int a=0; a < (matrix[0].length); a++){
        String toAdd = '';
        toAdd = matrix[i][a];
        if(a < (matrix[0].length-1)){
          toAdd = toAdd + ";";
        }
        formattedMatrix = formattedMatrix + toAdd;
      }
      if(i < (matrix.length-1)){
        formattedMatrix = formattedMatrix + "@";
      }
    }
  formattedMatrix = formattedMatrix + "\$";
  return formattedMatrix;
}

String printMatrix(List<List<String>> matrix){

  String formattedMatrix = '';

    for(int i=0; i < (matrix.length); i++){

      String startString = "| ";
      formattedMatrix = formattedMatrix + startString;

      for(int a=0; a < (matrix[0].length); a++){
        String toAdd = "[" + matrix[i][a] + "] ";
        formattedMatrix = formattedMatrix + toAdd;
      }

      String endString = "|";
      formattedMatrix = formattedMatrix + endString;

      if(i < matrix.length - 1){
        formattedMatrix = formattedMatrix + "\n";
      }
    }

  return formattedMatrix;
}

List<List<String>> matrixStringToList(String matrixString){

  var matrixStringSlice = matrixString.substring(0, matrixString.length - 1);
  var rowSplit = matrixStringSlice.split("@");
  List<List<String>> mainList = new List<List<String>>();

  for(int i = 0; i < rowSplit.length; i++){
    var colSplit = rowSplit[i].split(";");
    var colList = new List<String>();
    for(int a = 0; a < colSplit.length; a++){
      colList.add(colSplit[a]);
    }
    mainList.add(colList);
  }

  return mainList;

}
}