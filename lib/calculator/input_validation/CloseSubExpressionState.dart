import 'package:open_calc/calculator/input_validation/OpenSubExpressionState.dart';
import 'package:open_calc/calculator/input_validation/error_state.dart';
import 'package:open_calc/calculator/input_validation/next_operand_State.dart';
import 'package:open_calc/calculator/input_validation/start_state.dart';
import 'package:open_calc/calculator/input_validation/state.dart';
import 'package:open_calc/calculator/input_validation/validate_function.dart';

class CloseSubExpressionState extends State {
  //--Constructor--
  CloseSubExpressionState(ValidateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  int getNextState(String value, int counter){
    if(value == "("){
      counter = counter + 1;
      //update state
      context.setCurrentState(new OpenSubExpressionState(context));
    }
    else if(value == ")"){
      if(counter >= 1){
        counter = counter - 1;
        //remain in the same state
      }
      else {
        context.setCurrentState(new ErrorState(context));
      }
    }
    else if(value.startsWith(RegExp(r'[+-/*^]'))){
      //update state
      context.setCurrentState(new NextOperandState(context));
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

    return counter;
  }

}