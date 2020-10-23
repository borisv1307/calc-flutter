import 'package:open_calc/input_validation/next_operand_State.dart';
import 'package:open_calc/input_validation/start_state.dart';
import 'package:open_calc/input_validation/state.dart';
import 'package:open_calc/input_validation/validate_function.dart';

class SecondOperandState extends State {
  //--constructor--
  SecondOperandState(ValidateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  void getNextState(String value) {
    if(value.startsWith(RegExp(r'[0-9]'))){
      // remain in the same state
    }
    else if(value.startsWith(RegExp(r'[+-/*^]'))){
      context.setCurrentState(new NextOperandState(context));
    }
    else if(value.startsWith("=")){
      //Reaching here signifies a valid input expression
      context.setCurrentState(new StartState(context));
    }
    // else if(value.startsWith(")")){
    //   context.setCurrentState(new CloseSubExpressionState(context));
    // }
  }
}
