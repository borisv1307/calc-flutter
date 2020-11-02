
import 'package:open_calc/calculator/input_validation/CloseSubExpressionState.dart';
import 'package:open_calc/calculator/input_validation/OpenSubExpressionState.dart';
import 'package:open_calc/calculator/input_validation/error_state.dart';
import 'package:open_calc/calculator/input_validation/second_operand_state.dart';
import 'package:open_calc/calculator/input_validation/state.dart';
import 'package:open_calc/calculator/input_validation/validate_function.dart';

class NextOperandState extends State {
  //--Constructor--
  NextOperandState(ValidateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  int getNextState(String value, int counter) {
    if(value.startsWith(RegExp(r'[0-9]'))){
      context.setCurrentState(new SecondOperandState(context));
    }
    else if(value.startsWith(RegExp(r'[+-/*^=)]'))){
      context.setCurrentState(new ErrorState(context));
    }
    else if(value == "("){
      counter = counter + 1;
      context.setCurrentState(new OpenSubExpressionState(context));
    }

    return counter;
  }

}
