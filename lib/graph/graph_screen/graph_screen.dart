import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/graph_screen/graph_bounds.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_input_evaluator.dart';
import 'package:open_calc/graph/graph_screen/graph_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double X_PIXELS = 270;
const double Y_PIXELS = 163;

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
  
  GraphCursor cursor;
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
  List<Coordinates> coordinates;
  AdvancedCalculator calculator = AdvancedCalculator();
  int selectedIndex = -1;
  
  @override
  void initState() {
    cursor = GraphCursor(X_PIXELS, Y_PIXELS, GraphBounds(_xMin, _xMax, _yMin, _yMax, _step));
    super.initState();
  }

  void moveCursor(String direction) {
    setState(() {
      if (selectedIndex != -1) {  // trace mode
        if (direction == "LEFT") {
          trace(cursor.getXValue() - _step, selectedIndex);
        } else if (direction == "RIGHT") {
          trace(cursor.getXValue() + _step, selectedIndex);
        }
      } else {
        cursor.move(direction);
      }
    });
  }

  void trace(double x, int equationIndex) {
    setState(() {
      double y = calculator.calculateEquation(inputEquations[equationIndex], x);
      cursor.moveToCoordinates(x, y);
    });
  }

  void _beginTrace(int index) {
    if (selectedIndex == index) {  // exit trace mode
      selectedIndex = -1;
      cursor.moveToCoordinates(0, 0);
    } else {
      selectedIndex = index;
      trace(0, index);
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
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 652,
              ),
              child: CartesianGraph(
                Bounds(_xMin, _xMax, _yMin, _yMax),
                equations: inputEquations,
                cursorLocation: cursor.coordinates(),
              ),
            ),
            Container(
              color: Colors.black26,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 72,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("x = " + cursor.getXValue().toString(), style: mainStyle),
                        Text("y = " + cursor.getYValue().toString(), style: mainStyle),
                      ],
                    )
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          moveCursor('UP');
                        },
                        child: Icon(Icons.arrow_upward)
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: InkWell(
                              onTap: () {
                                moveCursor('LEFT');
                              },
                              child: Icon(Icons.arrow_back)
                            )
                          ),
                          InkWell(
                            onTap: () {
                              moveCursor('RIGHT');
                            },
                            child: Icon(Icons.arrow_forward)
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          moveCursor('DOWN');
                        },
                        child: Icon(Icons.arrow_downward)
                      ),
                    ]
                  )
                ],
              ),
            ),

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
                    initialValue: '$_step',
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
                        cursor.bounds = GraphBounds(_xMin, _xMax, _yMin, _yMax, _step);
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

