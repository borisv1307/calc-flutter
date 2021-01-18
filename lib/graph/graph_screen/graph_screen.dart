import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/graph_screen/graph_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  final FunctionDisplayController controller;
  GraphScreen(this.controller);

  @override
  State<StatefulWidget> createState() => GraphScreenState();
}

class GraphScreenState extends State<GraphScreen>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaleFormKey = GlobalKey<FormState>();
  List<String> inputEquations;

  // Scale Value, Range and Domain of x and y will be set and saved in these variable
  int _xMin = -10,
      _xMax = 10,
      _yMin = -10,
      _yMax = 10;

  Coordinates cursorLocation = Coordinates(135, 81);
  List<Coordinates> coordinates;

  void moveCursor(String direction) {
    setState(() {
      double updatedX = cursorLocation.x;
      double updatedY = cursorLocation.y;
      if (direction == "UP") {
        updatedY += 3;
      } else if (direction == "DOWN") {
        updatedY -= 3;
      } else if (direction == "RIGHT") {
        updatedX += 3;
      } else if (direction == "LEFT") {
        updatedX -= 3;
      }
      this.cursorLocation = Coordinates(updatedX, updatedY);
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  List<Widget> _getEquations() {
    List<Widget> displayedEquations = [];
    for (int i = 0; i < inputEquations.length; i++) {
      displayedEquations.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text("y"+ (i+1).toString() + " = " + inputEquations[i]),
          )
      );
    }
    return displayedEquations;
  }

  @override
  Widget build(BuildContext context) {
    this.inputEquations = widget.controller.translateInputs();
      bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 652,
                ),
                child: CartesianGraph(
                  Bounds(_xMin, _xMax, _yMin, _yMax),
                  equations: inputEquations,
                  cursorLocation: this.cursorLocation,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("x = " + (cursorLocation.x - 135).toString()),
                      Text("y = " + (cursorLocation.y - 81).toString()),
                    ],
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    ..._getEquations(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      endDrawer: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
          bottom: Radius.circular(10)
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            width: 200,
            height: 305,
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
                        setState(() {});
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      floatingActionButton: Visibility(
        visible: !keyboardIsOpened,
        child: Row(
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
      )
    );
  }
}

