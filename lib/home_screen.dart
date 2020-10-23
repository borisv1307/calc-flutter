import 'dart:developer';

import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/bridge/graph_bridge.dart';
import 'package:open_calc/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator_display/display_history.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Coordinates cursorLocation = Coordinates(50, 50);
  GraphBridge bridge = GraphBridge();
  List<DisplayHistory> history = [];
  int width = 270;
  int height = 162;

  List<Coordinates> _retrieveCoordinates() {
    List<Coordinates> allCoordinates = bridge.retrieve(
        (width / 2) * -1, (width / 2), (height / 2) * -1, (height / 2));
    return allCoordinates;
  }

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

  // Add a Drawer for scale window
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _openDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  final formKey = GlobalKey<FormState>();
  // Scale Value, Range and Domain of x and y will be set and saved in these variable
  int _xMin = -100,
      _xMax = 100,
      _yMin = -81,
      _yMax = 81,
      _xScl = 1,
      _yScl = 2,
      _xRes = 1;

  String userInputString = '';

  void setLabelInput(String keypadInput) {
    setState(() {
      if (keypadInput == "C") {
        userInputString = '';
      } else {
        userInputString = (userInputString + keypadInput);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // than having to individually change instances of widgets.
    return MaterialApp(
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                  actions: <Widget>[
                    // for hiding the drawer button
                    Container(),
                  ],
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.call_missed_outgoing)),
                      Tab(text: "y="),
                      Tab(icon: Icon(Icons.calculate)),
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  //TAB1------------------------------------------------------------
                  Scaffold(
                    key: _scaffoldKey,
                    endDrawer: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(10)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          color: Colors.white,
                          width: 200,
                          height: 485,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: '$_xMax',
                                    decoration:
                                        InputDecoration(labelText: 'X max:'),
                                    onSaved: (input) => {
                                      _xMax = int.parse(input),
                                      log('x_Max: ' + input)
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: '$_xMin',
                                    decoration:
                                        InputDecoration(labelText: 'X min:'),
                                    onSaved: (input) => {
                                      _xMin = int.parse(input),
                                      log('x_Min: ' + input)
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: '$_xScl',
                                    decoration:
                                        InputDecoration(labelText: 'X scale:'),
                                    onSaved: (input) => {
                                      _xScl = int.parse(input),
                                      log('x_Scl: ' + input)
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: '$_yMax',
                                    decoration:
                                        InputDecoration(labelText: 'Y max:'),
                                    onSaved: (input) => {
                                      _yMax = int.parse(input),
                                      log('y_Max: ' + input)
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: '$_yMin',
                                    decoration:
                                        InputDecoration(labelText: 'Y min:'),
                                    onSaved: (input) => {
                                      _yMin = int.parse(input),
                                      log('y_Min: ' + input)
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: '$_yScl',
                                    decoration:
                                        InputDecoration(labelText: 'Y scale:'),
                                    onSaved: (input) => {
                                      _yScl = int.parse(input),
                                      log('y_Min: ' + input)
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: '$_xRes',
                                    decoration:
                                        InputDecoration(labelText: 'X res:'),
                                    onSaved: (input) => {
                                      _xRes = int.parse(input),
                                      log('x_Res: ' + input)
                                    },
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      formKey.currentState.save();
                                    },
                                    child: Text("Save Changes"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                                Bounds(_xMin, _xMax, -81, 81),
                                coordinates: _retrieveCoordinates(),
                                cursorLocation: this.cursorLocation,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          moveCursor('UP');
                                        },
                                        child: Icon(Icons.arrow_upward)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(right: 25),
                                            child: InkWell(
                                                onTap: () {
                                                  moveCursor('LEFT');
                                                },
                                                child: Icon(Icons.arrow_back))),
                                        InkWell(
                                            onTap: () {
                                              moveCursor('RIGHT');
                                            },
                                            child: Icon(Icons.arrow_forward))
                                      ],
                                    ),
                                    InkWell(
                                        onTap: () {
                                          moveCursor('DOWN');
                                        },
                                        child: Icon(Icons.arrow_downward)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () {
                        _openDrawer();
                      },
                      label: Text('Scale'),
                      icon: Icon(Icons.crop),
                    ),
                  ),

                  //TAB2------------------------------------------------------------
                  Column(),
                  //TAB3------------------------------------------------------------
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 652 / MediaQuery.of(context).devicePixelRatio,
                        child: CalculatorDisplay(userInputString, history),
                      ),
                      Expanded(
                          flex: 5,
                          child: DefaultTabController(
                            length: 3,
                            child: Scaffold(
                                appBar: PreferredSize(
                                  preferredSize: Size.fromHeight(50.0),
                                  child: AppBar(
                                    bottom: TabBar(
                                      tabs: [
                                        Tab(text: 'Basic'),
                                        Tab(text: 'TBD'),
                                        Tab(text: 'TBD'),
                                      ],
                                    ),
                                  ),
                                ),
                                body: TabBarView(
                                  children: [
                                    Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: Row(children: [
                                            Expanded(
                                                flex: 20,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                        child: Text('  (  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('(');
                                                        }),
                                                    InkWell(
                                                        child: Text('  1  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('1');
                                                        }),
                                                    InkWell(
                                                        child: Text('  4  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('4');
                                                        }),
                                                    InkWell(
                                                        child: Text('  7  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('7');
                                                        }),
                                                    InkWell(
                                                        child: Text(' +/- ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('1');
                                                        })
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 20,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                        child: Text('  )  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput(')');
                                                        }),
                                                    InkWell(
                                                        child: Text('  2  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('2');
                                                        }),
                                                    InkWell(
                                                        child: Text('  5  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('5');
                                                        }),
                                                    InkWell(
                                                        child: Text('  8  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('8');
                                                        }),
                                                    InkWell(
                                                        child: Text('  0  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('0');
                                                        })
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 20,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                        child: Text('  C  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('C');
                                                        }),
                                                    InkWell(
                                                        child: Text('  3  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('3');
                                                        }),
                                                    InkWell(
                                                        child: Text('  6  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('6');
                                                        }),
                                                    InkWell(
                                                        child: Text('  9  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('9');
                                                        }),
                                                    InkWell(
                                                        child: Text('  .  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('.');
                                                        })
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 20,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                        child: Text('  /  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('/');
                                                        }),
                                                    InkWell(
                                                        child: Text('  x  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('*');
                                                        }),
                                                    InkWell(
                                                        child: Text('  -  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('-');
                                                        }),
                                                    InkWell(
                                                        child: Text('  +  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('+');
                                                        }),
                                                    InkWell(
                                                        child: Text('  =  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('1');
                                                        })
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 20,
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                        child: Text('  ^  ',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('^');
                                                        }),
                                                    InkWell(
                                                        child: Text('log(',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('log(');
                                                        }),
                                                    InkWell(
                                                        child: Text('ln(',
                                                            style: TextStyle(
                                                              fontSize: 40,
                                                            )),
                                                        onTap: () {
                                                          setLabelInput('ln(');
                                                        }),
                                                  ],
                                                )),
                                          ]))
                                    ]),
                                    Row(),
                                    Row(),
                                  ],
                                )),
                          )),
                    ],
                  ),
                ]))));
  }
}
