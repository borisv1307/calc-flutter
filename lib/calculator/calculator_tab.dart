import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/handler/command_handler.dart';
import 'package:open_calc/calculator/handler/input_handler.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/settings/settings_controller.dart';

class CalculatorTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalculatorTabState();
}

class CalculatorTabState extends State<CalculatorTab>{
  CalculatorDisplayController controller;
  InputHandler inputHandler;
  CommandHandler commandHandler;

  CalculatorTabState() {
    controller = CalculatorDisplayController();
    inputHandler= InputHandler(controller);
  }
  
  // loads calculator history, called after initState
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    List loadedHistory = SettingsController.of(context).calcHistory;
    controller.history = loadedHistory;
  }

  @override
  Widget build(BuildContext context) {
    commandHandler = CommandHandler(controller, SettingsController.of(context));
    return Container(
      color: Theme.of(context).colorScheme.background, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CalculatorDisplay(controller),
          ),
          Expanded(
            flex: 3,
            child: InputPad(
              SettingsController.of(context).calculationOptions, 
              inputHandler.handle, 
              commandHandler.handle
            )
          ),
        ],
      )
    );
  }
}
