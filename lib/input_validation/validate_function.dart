import 'package:open_calc/input_validation/error_state.dart';
import 'package:open_calc/input_validation/start_state.dart';
import 'package:open_calc/input_validation/state.dart';

class validateFunction {
  state currentState;
  
  validateFunction(){
    currentState= new start_state(this);
  }

  void setCurrentState(state currentState) {
    this.currentState = currentState;
  }

  state getCurrentState() {
    return currentState;
  }

  bool testFunction(String input){
    // Copy character by character into array
    for (int i = 0; i < input.length; i++) {
      currentState.getNextState(input[i]);

      if(currentState is error_state){
        return false;
      }
    }

    return true;
  }

}
