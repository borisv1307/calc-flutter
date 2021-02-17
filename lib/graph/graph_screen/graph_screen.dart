import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/graph_details.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/graph_display_navigator.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/graph_navigator.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle_selection.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/interactive_graph.dart';

import 'graph_input_evaluator.dart';

class GraphScreen extends StatefulWidget {
  final FunctionDisplayController controller;
  final VariableStorage storage;
  final GraphInputEvaluator evaluator;
  GraphScreen(this.storage, this.controller)
      : evaluator = GraphInputEvaluator(storage);

  @override
  State<StatefulWidget> createState() => GraphScreenState();
}

class GraphScreenState extends State<GraphScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> inputEquations;
  ScaleSettings scaleSettings = ScaleSettings();
  TextToggleSelection selection = TextToggleSelection('equations');
  GraphCursor cursorDetails = GraphCursor();
  int chosenEquationIndex = -1;

  @override
  Widget build(BuildContext context) {
    this.inputEquations =
        widget.evaluator.translateInputs(widget.controller.inputs);
    InteractiveGraph interactiveGraph = InteractiveGraph(
        this.inputEquations,
        this.scaleSettings,
        this.cursorDetails,
        this.chosenEquationIndex = chosenEquationIndex);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          if (!isKeyboardVisible)
            Stack(alignment: AlignmentDirectional.center, children: <Widget>[
              interactiveGraph,
              GraphDisplayNavigator(scaleSettings),
            ]),
          Row(
            children: <Widget>[
              Expanded(
                  child: GraphNavigator(
                      this.cursorDetails, selection, this.scaleSettings)),
            ],
          ),
          GraphDetails(this.inputEquations, selection, this.scaleSettings,
              this.cursorDetails),
          SizedBox(
            height: 70,
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
