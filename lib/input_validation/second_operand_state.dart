import 'package:open_calc/input_validation/calculate_state.dart';
import 'package:open_calc/input_validation/next_operand_State.dart';
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
      //set the second operand value
      // String newValue= context.getSecondOperand() + value;
      // context.calculator.setOutput(context.calculator.getOutput() + value);

      //update calculator view and state
      // context.setSecondOperand(newValue);
      // context.trackOperation.set(context.trackOperation.size()-1, new Operand(newValue));
    }
    else if(value.startsWith(RegExp(r'[+-/*]'))){
      //update calculator view and state
      // context.calculator.setOutput(context.calculator.getOutput() + value);
      // context.trackOperation.add(new Operator(value));
      context.setCurrentState(new NextOperandState(context));
    }
    else if(value.startsWith("C")){
      //update calculator view and reset to start state
      // context.setFirstOperand(null);
      // context.setOperator(null);
      // context.setSecondOperand(null);
      // context.trackOperation = new ArrayList<OperationModel>();
      // context.subExpressionTree = new Operator(null);
      // context.expressionTree = new Operator(null);
      // context.setCurrentState(new StartState(context));
      // context.calculator.setOutput("");
    }
    else if(value.startsWith("=")){
      //update state
      context.setCurrentState(new CalculateState(context));
    }
  }
}
