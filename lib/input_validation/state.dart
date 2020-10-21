// This class is part of the state pattern and represents an abstract State class
import 'validate_function.dart';

abstract class State {
  //--Attributes--
  ValidateFunction context;
  String previousState="none";

  //--Constructor--
  State(ValidateFunction context) {
    this.context = context;
  }

  //--Accessors and mutators--
  ValidateFunction getContext() {
    return this.context;
  }

  void setContext(ValidateFunction context) {
    this.context = context;
  }

  //--abstract methods--
  void getNextState(String value);
}