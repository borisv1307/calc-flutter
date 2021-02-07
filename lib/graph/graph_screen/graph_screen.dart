import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
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
  int chosenEquationIndex = 0;
  double drawerWidth = 200;
  double drawerHeight = 305;
  TextStyle mainStyle = TextStyle(fontFamily: 'RobotoMono', fontSize: 20);
  TextStyle titleStyle = TextStyle(fontFamily: 'RobotoMono', fontSize: 17);
  List<Coordinates> coordinates;

  @override
  void initState() {
    cursor = GraphCursor(X_PIXELS, Y_PIXELS, Bounds(_xMin, _xMax, _yMin, _yMax));
    super.initState();
  }

  void moveCursor(String direction) {
    setState(() {
      cursor.move(direction);
    });
  }

  void trace(double x, [int equationIndex = 0]) {
    // TODO
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
      body: Center(
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
                chosenEquationIndex: chosenEquationIndex,
                // lineColor: Colors.black,
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
              // padding: EdgeInsets.only(bottom: 100),
              child: Expanded(
                // margin: EdgeInsets.only(bottom: 100),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: inputEquations.length + 1,
                  itemBuilder: (context, int index) {
                    if (index == inputEquations.length) {
                      return ListTile();
                    }
                    return ListTile(
                      leading: Text("y"+ (index+1).toString() + " =", style: titleStyle),
                      title: Text(inputEquations[index], style: mainStyle),
                      selected: index == chosenEquationIndex,
                      onTap: () {
                        setState(() {
                          chosenEquationIndex = index;
                        });
                      },

                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1.5),
                ),
              ),
            ),
            SizedBox(
              height: 75,
            )
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
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _scaleFormKey.currentState.save();
                      Navigator.of(context).pop();  // close drawer
                      setState(() {
                        cursor.bounds = Bounds(_xMin, _xMax, _yMin, _yMax);
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

