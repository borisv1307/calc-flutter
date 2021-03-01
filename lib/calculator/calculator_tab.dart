import 'package:advanced_calculation/angular_unit.dart';
import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator/calculator_display/calculator_display_controller.dart';
import 'package:open_calc/calculator/handler/command_handler.dart';
import 'package:open_calc/calculator/handler/input_handler.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_pad.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/settings/settings_controller.dart';

class CalculatorTab extends StatefulWidget {
  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;
  final Function(InputItem input) inputFunction;

  CalculatorTab(this.storage, this.matrixStorage, this.inputFunction);
  @override
  State<StatefulWidget> createState() => CalculatorTabState(storage, matrixStorage, inputFunction);
}

class CalculatorTabState extends State<CalculatorTab>{
  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;
  final Function(InputItem input) inputFunction;

  final GlobalKey<CalculatorTabState> calcKey = GlobalKey();

  CalculatorTabState(this.storage, this.matrixStorage, this.inputFunction);

  @override
  Widget build(BuildContext context) {
    return new Navigator(
      initialRoute: 'main',
      key: calcKey,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch(settings.name){
          case 'main':
            builder = (BuildContext context) => MainCalculator(this.storage, this.matrixStorage);
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
      );
  }
}

class MainCalculator extends StatefulWidget {
  
  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;

  MainCalculator(this.storage,this.matrixStorage);

  @override
  State<StatefulWidget> createState() => MainCalculatorState(this.storage,this.matrixStorage);
}

class MainCalculatorState extends State<MainCalculator> {

  final VariableStorage storage;
  final List<List<List<String>>> matrixStorage;


  CalculatorDisplayController controller;
  InputHandler inputHandler;
  CommandHandler commandHandler;

  MainCalculatorState(this.storage, this.matrixStorage) {
    controller = CalculatorDisplayController();
    inputHandler= InputHandler(controller);

    commandHandler = CommandHandler(controller, storage, CalculationOptions());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SettingsController.of(context).addListener(_updateOptions);
    _updateOptions();
  }

  void _updateOptions() {
    setState(() {
      int decimals = SettingsController.of(context).decimalPlaces;
      AngularUnit unit = SettingsController.of(context).angularUnit;
      commandHandler.updateOptions(decimals, unit);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CalculatorDisplay(
                controller,
            ),
          ),
          Expanded(
            flex: 3,
            child: InputPad(storage, inputHandler.handle, commandHandler.handle, options, matrixStorage)

          ),
        ],
      )
    );
  }
}
