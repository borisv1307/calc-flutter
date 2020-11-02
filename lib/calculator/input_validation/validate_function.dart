
import 'package:open_calc/calculator/input_validation/error_state.dart';
import 'package:open_calc/calculator/input_validation/start_state.dart';
import 'package:open_calc/calculator/input_validation/state.dart';

class ValidateFunction {
  State currentState;
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
    input = input + " = ";
    List<String> inputString = input.split(" ");

    for(int i = 0; i < inputString.length; i++){
      if(inputString[i].isEmpty){
        inputString.removeAt(i);
      }
    }
    currentState= new StartState(this);
    for(int i = 0; i < inputString.length; i++){
      if(inputString[i].length == 1){
        currentState.getNextState(inputString[i]);

        if(currentState is ErrorState){
          return false;
        }
      }else if(inputString[i].length == 2){
        if(lengthTwoFunc.contains(inputString[i]) == false){
          return false;
        }
      }
      else if(inputString.length == 3){
        if(lengthThreeFunc.contains(inputString[i]) == false){
          return false;
        }
      }
    }
    //currentState= new StartState(this);
    // Copy character by character into array
    // for (int i = 0; i < inputString.length; i++) {
    //   currentState.getNextState(inputString[i]);
    //
    //   if(currentState is ErrorState){
    //     return false;
    //   }
    // }

    return true;
  }

}
