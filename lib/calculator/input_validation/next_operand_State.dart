import 'package:open_calc/calculator/input_validation/close_subexpression_state.dart';
import 'package:open_calc/calculator/input_validation/error_state.dart';
import 'package:open_calc/calculator/input_validation/operator_state.dart';
import 'package:open_calc/calculator/input_validation/start_state.dart';
import 'package:open_calc/calculator/input_validation/state.dart';
import 'package:open_calc/calculator/input_validation/validate_function.dart';

class NextOperandState extends State {
  //--constructor--
  NextOperandState(ValidateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  int getNextState(String value, int counter) {
    if(value.startsWith(RegExp(r'[+-/*^]'))){
      context.setCurrentState(new OperatorState(context));
    }
    else if(value == "="){
      // reaching here signifies a valid input expression
      if(counter > 0){
        context.setCurrentState(new ErrorState(context));
      }
      else {
        context.setCurrentState(new StartState(context)); 
      }
    }

    else if(value.startsWith(")")){
      counter = counter - 1;
      context.setCurrentState(new CloseSubExpressionState(context));
    }
    else if(value == "("){
      context.setCurrentState(new ErrorState(context));
    }
    else {
      context.setCurrentState(new ErrorState(context));
    }

    return counter;
  }
}
