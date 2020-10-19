

// This class is part of the state pattern and represents an abstract State class
import 'validate_function.dart';

abstract class state {
  //--Attributes--
  validateFunction context;
  String previousState="none";

  //--Constructor--
  state(validateFunction context) {
    this.context = context;
  }

  //--Accessors and mutators--
  validateFunction getContext() {
    return this.context;
  }

  void setContext(validateFunction context) {
    this.context = context;
  }

  //--abstract methods--
  void getNextState(String value);
}