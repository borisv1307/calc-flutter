import 'package:open_calc/calculator/input_validation/first_operand_state.dart';
import 'package:open_calc/calculator/input_validation/start_state.dart';
import 'package:open_calc/calculator/input_validation/state.dart';
import 'package:open_calc/calculator/input_validation/validate_function.dart';


class CalculateState extends State {
  //--Constructor--
  CalculateState(ValidateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  void getNextState(String value) {
    if(value.startsWith(RegExp(r'[0-9]'))){
      //start a new calculation, and reset
      //update calculator view and transition to FirstOperand state
      //set the first operator value
      // context.calculator.setOutput(value);
      // context.setFirstOperand(value);
      // context.trackOperation.add(new Operand(value));
      // context.subExpressionTree = new Operator(null);
      // context.expressionTree = new Operator(null);
      // context.setOperator(null);
      // context.setSecondOperand(null);
      context.setCurrentState(new FirstOperandState(context));
    }
    else {
      //update calculator view and reset to start state
      // context.setFirstOperand(null);
      // context.setOperator(null);
      // context.setSecondOperand(null);
      // context.trackOperation = new ArrayList<OperationModel>();
      // context.subExpressionTree.setValue(null);
      // context.expressionTree.setValue(null);
      context.setCurrentState(new StartState(context));
      //context.calculator.setOutput("");
    }
  }
}