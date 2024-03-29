import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/graph_details.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/graph_navigator.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_line.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_lines.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/interactive_graph.dart';
import 'package:open_calc/graph/graph_screen/graph_input_evaluator.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle/text_toggle_selection.dart';
import 'package:open_calc/settings/settings_controller.dart';


class GraphScreen extends StatefulWidget {
  final FunctionDisplayController controller;
  final GraphInputEvaluator evaluator;
  GraphScreen(this.controller) : evaluator = GraphInputEvaluator();

  @override
  State<StatefulWidget> createState() => GraphScreenState();
}

class GraphScreenState extends State<GraphScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  GraphLines inputEquations;
  ScaleSettings scaleSettings = ScaleSettings();
  TextToggleSelection selection = TextToggleSelection('equations');
  GraphCursor cursorDetails = GraphCursor();
  int chosenEquationIndex = -1;

  @override
  Widget build(BuildContext context) {
    this.inputEquations =
        GraphLines(widget.evaluator.translateInputs(widget.controller.inputs, SettingsController.of(context)).map((equation) => GraphLine(equation)).toList());
    InteractiveGraph interactiveGraph = InteractiveGraph(
        this.inputEquations,
        this.scaleSettings,
        this.cursorDetails);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(
            children: <Widget>[
          if (!isKeyboardVisible)
            Expanded(
              flex:3,
              child: interactiveGraph
            ),
          Flexible(
              child: GraphNavigator(this.cursorDetails, selection, this.scaleSettings)
          ),
          Expanded(
            flex:4,
            child: GraphDetails(this.inputEquations, selection, this.scaleSettings, this.cursorDetails)
          )
        ]);
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back),
        label: Text("Back"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
