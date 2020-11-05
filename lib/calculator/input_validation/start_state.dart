import 'package:open_calc/calculator/input_validation/error_state.dart';
import 'package:open_calc/calculator/input_validation/state.dart';
import 'package:open_calc/calculator/input_validation/validate_function.dart';

import 'first_operand_state.dart';

class StartState extends State {
  //--Constructor--
  StartState(ValidateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  void getNextState(String value){
    if(value.startsWith(RegExp(r'[0-9]'))){
      //set the first operand value
      //context.setFirstOperand(value);
      //context.trackOperation.add(new Operand(value));

      //update calculator view and state
      context.setCurrentState(new FirstOperandState(context));
    }
    else {
      //update state
      context.setCurrentState(new ErrorState(context));
    }

  }

}