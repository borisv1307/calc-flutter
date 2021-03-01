import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/graph_screen/graph_screen.dart';
import 'package:open_calc/graph/function_screen/function_screen.dart';

class GraphTab extends StatefulWidget {
  final VariableStorage storage;

  GraphTab(this.storage);

  State<StatefulWidget> createState() => GraphTabState();
}

class GraphTabState extends State<GraphTab> {

  final FunctionDisplayController controller = FunctionDisplayController();

  @override
  Widget build(BuildContext context) {
    return new Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (BuildContext context) => FunctionScreen(widget.storage, controller);
            break;
          case '/graphScreen':
            builder = (BuildContext context) => GraphScreen(widget.storage, controller);
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}