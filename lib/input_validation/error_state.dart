// This class is part of the state pattern and inherits from abstract State class
// It represents the Error state for the calculator
import 'package:open_calc/input_validation/start_state.dart';
import 'package:open_calc/input_validation/state.dart';
import 'package:open_calc/input_validation/validate_function.dart';

class error_state extends state {
  //--Constructor--
  error_state(validateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  void getNextState(String value) {
    if(value.startsWith("C")){
      //This represents if the user choses 'Reset' option
      //update the calculator view and reset to start state
      // context.trackOperation = new List<OperationModel>();
      // context.setFirstOperand(null);
      // context.setOperator(null);
      // context.setSecondOperand(null);
      // context.subExpressionTree = new Operator(null);
      // context.expressionTree = new Operator(null);
      context.setCurrentState(new start_state(context));
      // context.calculator.setOutput("");
    }
  }

}