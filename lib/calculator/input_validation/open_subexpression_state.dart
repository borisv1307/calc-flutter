import 'package:open_calc/calculator/input_validation/error_state.dart';
import 'package:open_calc/calculator/input_validation/operator_state.dart';
import 'package:open_calc/calculator/input_validation/state.dart';
import 'package:open_calc/calculator/input_validation/validate_function.dart';

import 'first_operand_state.dart';

class OpenSubExpressionState extends State {
  //--Constructor--
  OpenSubExpressionState(ValidateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  int getNextState(String value, int counter){
    if(value == "("){
      // remain in the same state
      counter = counter + 1;
    }
    else if(RegExp(r'^-?[0-9]+(.[0-9]+)?$').hasMatch(value)){
      //update state
      context.setCurrentState(new FirstOperandState(context));
    }
    else if(value.startsWith(RegExp(r'[+-]'))){
      //update state
      context.setCurrentState(new OperatorState(context));
    }
    else if(value.startsWith(RegExp(r'[)^*/=]'))){
      //update state
      context.setCurrentState(new ErrorState(context));
    }
    else {
      context.setCurrentState(new ErrorState(context));
    }

    return counter;
  }

}