import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/graph_navigator.dart';
import 'package:open_calc/graph/graph_screen/graph_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/interactive_graph.dart';

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
  double _step = 1;
  double drawerWidth = 200;
  double drawerHeight = 365;
  TextStyle mainStyle = TextStyle(fontFamily: 'RobotoMono', fontSize: 20);
  TextStyle titleStyle = TextStyle(fontFamily: 'RobotoMono', fontSize: 23);
  AdvancedCalculator calculator = AdvancedCalculator();
  int selectedIndex = -1;

  GraphCursor cursorDetails = GraphCursor();

  void moveCursor(Coordinates requestedLocation) {
    Coordinates updatedLocation = requestedLocation;
    setState(() {
      if(selectedIndex != -1){
        double y = calculator.calculateEquation(inputEquations[selectedIndex], requestedLocation.x);
        updatedLocation = Coordinates(requestedLocation.x, y);
      }
      cursorDetails.location = updatedLocation;
    });
  }

  List<List<Coordinates>> _getCoordinates() {
    List<List<Coordinates>> allCoordinates = [];
    for (int i = 0; i < inputEquations.length; i++) {
      List<Coordinates> coords = [];
      for (double x = _xMin.toDouble(); x <= _xMax; x += _step) {
        double y = calculator.calculateEquation(inputEquations[i], x);
        coords.add(Coordinates(x, y));
      }
      allCoordinates.add(coords);
    }
     return allCoordinates;
  }

  void _beginTrace(int index) {
    if (selectedIndex == index) {  // exit trace mode
      selectedIndex = -1;
    } else {
      selectedIndex = index;
      moveCursor(cursorDetails.location);
    }
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
            InteractiveGraph(this.inputEquations,Bounds(_xMin, _xMax, _yMin, _yMax),this.cursorDetails.location,this.moveCursor),
            GraphNavigator(this.cursorDetails,this.moveCursor),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: inputEquations.length + 1,
                itemBuilder: (context, int index) {
                  if (index == inputEquations.length) {
                    return ListTile();
                  }
                  return ListTileTheme(
                    selectedColor: Colors.black,
                    selectedTileColor: Colors.green[100],
                    child: ListTile(
                      leading: Text("y"+ (index+1).toString() + "=", style: titleStyle),
                      title: Text(inputEquations[index], style: mainStyle),
                      selected: index == selectedIndex,
                      onTap: () {
                        setState(() {
                          _beginTrace(index);
                        });
                      }
                    )
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1.5),
              ),
            ),
          ],
        ),
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
                      _step = double.parse(input),
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
                        cursorDetails.step = _step;
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
              showBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return GraphTable(coordinates: _getCoordinates());
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

