import 'dart:developer';
import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/bridge/graph_bridge.dart';
import 'package:open_calc/calculator/calculator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Coordinates cursorLocation = Coordinates(50, 50);
  GraphBridge bridge = GraphBridge();
  int width = 270;
  int height = 162;

  List<Coordinates> _retrieveCoordinates() {
    List<Coordinates> allCoordinates = bridge.retrieveGraph(
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
      _yMin = -80,
      _yMax = 80,
      _xScl = 1,
      _yScl = 2,
      _xRes = 1;



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
                                Bounds(_xMin, _xMax, _yMin, _yMax),
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
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(labelText: 'y = '),
                                onSaved: (input) => {log(input)},
                              ),
                              ElevatedButton(
                                  onPressed: null,
                                  child: Text("Generate Graph"))
                            ],
                          ),
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
        Calculator()
      ]  
    )
    )
    )
  );
  }
}