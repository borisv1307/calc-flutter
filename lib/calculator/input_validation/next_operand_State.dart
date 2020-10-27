
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
  void getNextState(String value) {
    if(value.startsWith(RegExp(r'[0-9]'))){
      //set the second operand value
      //context.setSecondOperand(value);
      //context.trackOperation.add(new Operand(value));

      //update calculator view and state
      //context.calculator.setOutput(context.calculator.getOutput() + value);
      context.setCurrentState(new SecondOperandState(context));
    }
    else if(value.startsWith(RegExp(r'[+-/*]'))){
      //update calculator view and state
      context.setCurrentState(new ErrorState(context));
      //context.calculator.setOutput("ERROR");
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
  }

}
