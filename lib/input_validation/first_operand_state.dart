import 'package:open_calc/input_validation/error_state.dart';
import 'package:open_calc/input_validation/next_operand_State.dart';
import 'package:open_calc/input_validation/start_state.dart';
import 'package:open_calc/input_validation/state.dart';
import 'package:open_calc/input_validation/validate_function.dart';

class first_operand_state extends state {
  //--Constructor--
  first_operand_state(validateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  void getNextState(String value) {
    if(value.startsWith(RegExp(r'[0-9]'))){
      //set the first operand value
      //String newValue= context.getFirstOperand() + value;
      //context.calculator.setOutput(newValue);

      //update state
      //context.setFirstOperand(newValue);
      //context.trackOperation.set(context.trackOperation.size()-1, new Operand(newValue));
    }
    else if(value.startsWith(RegExp(r'[+-/*]'))){
      //set the first operator value
      // context.setOperator(value);
      // context.trackOperation.add(new Operator(value));
      //
      // //update calculator view and state
      // String newValue= context.getFirstOperand() + value;
      // context.calculator.setOutput(newValue);
      context.setCurrentState(new next_operand_state(context));
    }
    else if(value.startsWith("C")){
      //update calculator view and reset to start state
      // context.setFirstOperand(null);
      // context.setOperator(null);
      // context.setSecondOperand(null);
      // context.trackOperation = new ArrayList<OperationModel>();
      // context.subExpressionTree = new Operator(null);
      // context.expressionTree = new Operator(null);
      context.setCurrentState(new start_state(context));
      // context.calculator.setOutput("");
    }
    else if(value.startsWith("=")){
      //update state
      //context.calculator.setOutput("ERROR");
      context.setCurrentState(new error_state(context));
    }
  }
}
