import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/graph_details.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/graph_navigator.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle_selection.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle_selector.dart';
import 'package:open_calc/graph/graph_screen/graph_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Greg/IdeaProjects/se-calc/calc-flutter/lib/graph/graph_screen/interactive_graph/interactive_graph.dart';

import 'graph_input_evaluator.dart';

class GraphScreen extends StatefulWidget {
  final FunctionDisplayController controller;
  final VariableStorage storage;
  final GraphInputEvaluator evaluator;
  GraphScreen(this.storage, this.controller) : evaluator = GraphInputEvaluator(storage);

  @override
  State<StatefulWidget> createState() => GraphScreenState();
}

class GraphScreenState extends State<GraphScreen>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaleFormKey = GlobalKey<FormState>();
  List<String> inputEquations;
  int _xMin = -10,
      _xMax = 10,
      _yMin = -10,
      _yMax = 10;
  double drawerWidth = 200;
  double drawerHeight = 365;
  TextStyle mainStyle = TextStyle(fontFamily: 'RobotoMono', fontSize: 20);
  List<Coordinates> coordinates = [];
  AdvancedCalculator calculator = AdvancedCalculator();
  int selectedIndex = -1;
  TextToggleSelection selection = TextToggleSelection('equations');
  GraphCursor cursorDetails = GraphCursor();

  double _roundToInterval(double coordinate, double interval){
    return (coordinate/interval).round()/interval;
  }

  void moveCursor(Coordinates requestedLocation) {
    Coordinates updatedLocation = requestedLocation;
    setState(() {
      if(selectedIndex != -1){
        double y = calculator.calculateEquation(inputEquations[selectedIndex], requestedLocation.x);
        updatedLocation = Coordinates(requestedLocation.x, y);
      }
      cursorDetails.location = Coordinates(_roundToInterval(updatedLocation.x,cursorDetails.step),_roundToInterval(updatedLocation.y,cursorDetails.step));
    });
  }

  void _traceEquation(int index) {
    setState(() {
      if (selectedIndex == index) {  // exit trace mode
        selectedIndex = -1;
        cursorDetails.color = Colors.blue;
      } else {
        selectedIndex = index;
        cursorDetails.color = Colors.red;
        moveCursor(cursorDetails.location);
      }
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    this.inputEquations = widget.evaluator.translateInputs(widget.controller.inputs);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InteractiveGraph(this.inputEquations,Bounds(_xMin, _xMax, _yMin, _yMax),this.cursorDetails,this.moveCursor),
            GraphNavigator(this.cursorDetails,this.moveCursor,selection),
            GraphDetails(this.inputEquations,this.selectedIndex,this._traceEquation,selection)
          ]
        )
      ),

      endDrawer: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: Colors.white,
          width: drawerWidth,
          height: drawerHeight,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: _scaleFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: '$_xMax',
                    decoration:
                    InputDecoration(labelText: 'X max:'),
                    onSaved: (input) => {
                      _xMax = int.parse(input),
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: '$_xMin',
                    decoration:
                    InputDecoration(labelText: 'X min:'),
                    onSaved: (input) => {
                      _xMin = int.parse(input),
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: '$_yMax',
                    decoration:
                    InputDecoration(labelText: 'Y max:'),
                    onSaved: (input) => {
                      _yMax = int.parse(input),
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: '$_yMin',
                    decoration:
                    InputDecoration(labelText: 'Y min:'),
                    onSaved: (input) => {
                      _yMin = int.parse(input),
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: '${cursorDetails.step}',
                    decoration:
                    InputDecoration(labelText: 'Step:'),
                    onSaved: (input) => {
                      cursorDetails.step = double.parse(input),
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _scaleFormKey.currentState.save();
                      Navigator.of(context).pop();  // close drawer
                      setState(() {
                        cursorDetails.step = cursorDetails.step;
                      });
                    },
                    child: Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 34),
            child: FloatingActionButton.extended(
              onPressed: () { Navigator.of(context).pop(); },
              icon: Icon(Icons.arrow_back),
              label: Text("Back"),
              backgroundColor: Colors.red,
              heroTag: 1,
            ),
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.green,
            label: Text('Table'),
            icon: Icon(Icons.menu_book),
            heroTag: 2,
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return GraphTable(coordinates: this.coordinates);
                }
              );
            }
          ),
          FloatingActionButton.extended(
            onPressed: () {
              _openDrawer();
            },
            label: Text('Scale'),
            icon: Icon(Icons.crop),
            heroTag: 3
          ),
        ],
      )
    );
  }
}

