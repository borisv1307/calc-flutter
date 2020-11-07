import 'package:open_calc/calculator/input_validation/open_subexpression_state.dart';
import 'package:open_calc/calculator/input_validation/error_state.dart';
import 'package:open_calc/calculator/input_validation/next_operand_state.dart';
import 'package:open_calc/calculator/input_validation/state.dart';
import 'package:open_calc/calculator/input_validation/validate_function.dart';

class OperatorState extends State {
  //--Constructor--
  OperatorState(ValidateFunction context) : super(context);

  //--Methods--

  //The method is used to determine the next state for a given value
  // and used for transitioning from one state to another
  @override
  int getNextState(String value, int counter) {
    if(RegExp(r'^-?[0-9]+(.[0-9]+)?$').hasMatch(value)){
      //set the second operand value
      //context.setSecondOperand(value);
      //context.trackOperation.add(new Operand(value));

      //update calculator view and state
      //context.calculator.setOutput(context.calculator.getOutput() + value);
      context.setCurrentState(new NextOperandState(context));
    }
    else if(RegExp(r'^[+-/*^=)]$').hasMatch(value)){
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
    else if(value == "("){
      counter = counter + 1;
      context.setCurrentState(new OpenSubExpressionState(context));
    }
    else {
      context.setCurrentState(new ErrorState(context));
    }    

    return counter;
  }

}
