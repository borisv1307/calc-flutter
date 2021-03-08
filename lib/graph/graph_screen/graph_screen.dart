import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/graph_details.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_input_evaluator.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/graph_navigator.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle/text_toggle_selection.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/interactive_graph.dart';

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
  static int chosenEquationIndex = -1;
  bool _isExpanded = false;

  void _toggleExpand(double height) {
    if (_isExpanded == false) {
      setState(() {
        scaleSettings.yMax *= height ~/ 652;
        scaleSettings.yMin *= height ~/ 652;
        InteractiveGraphState.graphHeight = height;
      });
    } else {
      setState(() {
        scaleSettings.yMax = 10;
        scaleSettings.yMin = -10;
        InteractiveGraphState.graphHeight = 652;
      });
    }
    _isExpanded = !_isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    this.inputEquations =
        widget.evaluator.translateInputs(widget.controller.inputs);
    InteractiveGraph interactiveGraph = InteractiveGraph(this.inputEquations,
        this.scaleSettings, this.cursorDetails, chosenEquationIndex);
    double screenHeight = MediaQuery.of(context).size.height *
            MediaQuery.of(context).devicePixelRatio -
        MediaQuery.of(context).padding.top -
        378;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Column(children: <Widget>[
          if (!isKeyboardVisible)
            Expanded(
                flex: 3,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    interactiveGraph,
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Opacity(
                        opacity: 0.25,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              onTap: () {
                                _toggleExpand(screenHeight);
                              },
                              child: Icon(
                                Icons.aspect_ratio,
                                size: 36,
                              )),
                        ),
                      ),
                    ),
                  ],
                )),
          Visibility(
            visible: !_isExpanded,
            child: Flexible(
                child: GraphNavigator(
                    this.cursorDetails, selection, this.scaleSettings)),
          ),
          Visibility(
            visible: !_isExpanded,
            child: Expanded(
                flex: 4,
                child: GraphDetails(this.inputEquations, selection,
                    this.scaleSettings, this.cursorDetails)),
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
