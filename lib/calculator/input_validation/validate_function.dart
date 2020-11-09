
import 'package:open_calc/calculator/input_validation/error_state.dart';
import 'package:open_calc/calculator/input_validation/start_state.dart';
import 'package:open_calc/calculator/input_validation/state.dart';

import 'open_subexpression_state.dart';

class ValidateFunction {
  State currentState;
  int counter = 0;
  List<String> lengthTwoFunc = ["ln"];
  List<String> lengthThreeFunc = ["log","sin","cos","tan"];

  ValidateFunction(){
    currentState= new StartState(this);
  }

  void setCurrentState(State currentState) {
    this.currentState = currentState;
  }

  State getCurrentState() {
    return currentState;
  }

  bool testFunction(String input){
    this.counter = 0;
    input = input + " = ";
    List<String> inputString = input.split(" ");

    for(int i = 0; i < inputString.length; i++){
      if(inputString[i].isEmpty){
        inputString.removeAt(i);
      }
    }

    currentState= new StartState(this);

    for(int i = 0; i < inputString.length; i++){
      if(inputString[i] == "-("){ //handle expression special case
        // Increment the counter and update state
        this.counter = this.counter + 1;
        currentState = new OpenSubExpressionState(this);
      }
      else if(RegExp(r'^-?[0-9]+(.[0-9]+)?$').hasMatch(inputString[i]) || inputString[i].length == 1) {  // numbers or operands
        this.counter = currentState.getNextState(inputString[i], counter);

        if(currentState is ErrorState){
          return false;
        }
      }
      else if(inputString[i].length == 2){
        if(lengthTwoFunc.contains(inputString[i]) == false){
          return false;
        }
      }
      else if(inputString[i].length == 3){
        if(lengthThreeFunc.contains(inputString[i]) == false){
          return false;
        }
      }
      else {
        return false;
      }
    }

    return true;
  }

}
