import 'package:open_calc/input_validation/error_state.dart';
import 'package:open_calc/input_validation/start_state.dart';
import 'package:open_calc/input_validation/state.dart';

class ValidateFunction {
  State currentState;
  
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
    // Copy character by character into array
    for (int i = 0; i < input.length; i++) {
      currentState.getNextState(input[i]);

      if(currentState is ErrorState){
        return false;
      }
    }

    return true;
  }

}
