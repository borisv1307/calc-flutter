import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/command_item.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/settings/settings_controller.dart';

class GraphInputHandler{
  final FunctionDisplayController controller;
  final BuildContext context;  // the correct context for the Navigator
  final GlobalKey<FormState> formKey;  // the state of the input form

  GraphInputHandler(this.controller, this.context, this.formKey);

  void handleInput(InputItem inputItem) {
    controller.input(inputItem);
    SettingsController.of(context).setFunctionList(controller.inputs);
  }

  void handleCommand(CommandItem command) {
    if (command == CommandItem.GRAPH) {
      if(formKey.currentState.validate()) {
        Navigator.of(context).pushNamed("/graphScreen");
      }
    } else if (command == CommandItem.DELETE) {
      controller.delete();
      SettingsController.of(context).setFunctionList(controller.inputs);
    } else if(command ==CommandItem.CLEAR) {
      controller.clearInput();
      SettingsController.of(context).setFunctionList(controller.inputs);
    }
  }

}