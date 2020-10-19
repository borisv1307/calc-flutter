import 'dart:developer';

import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/bridge/graph_bridge.dart';

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
  String _xMin, _xMax, _yMin, _yMax, _xScl, _yScl, _xRes;

  @override
  Widget build(BuildContext context) {
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          // for hiding the drawer button
          Container(),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 652,
            ),
            child: CartesianGraph(
              Bounds(-135, 135, -81, 81),
              coordinates: _retrieveCoordinates(),
              cursorLocation: this.cursorLocation,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Column(
              children: [
                InkWell(
                    onTap: () {
                      moveCursor('UP');
                    },
                    child: Icon(Icons.arrow_upward)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ])
        ],
      ),
      endDrawer: ClipRRect(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(10), bottom: Radius.circular(10)),
        child: Container(
          color: Colors.white,
          width: 150,
          height: 500,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'X max:'),
                    onSaved: (input) => {_xMax = input, log('x_Max: ' + input)},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'X min:'),
                    onSaved: (input) => {_xMin = input, log('x_Min: ' + input)},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'X scale:'),
                    onSaved: (input) => {_xScl = input, log('x_Scl: ' + input)},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Y max:'),
                    onSaved: (input) => {_yMax = input, log('y_Max: ' + input)},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Y min:'),
                    onSaved: (input) => {_yMin = input, log('y_Min: ' + input)},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Y scale:'),
                    onSaved: (input) => {_yScl = input, log('y_Min: ' + input)},
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'X res:'),
                    onSaved: (input) => {_xRes = input, log('x_Res: ' + input)},
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _openDrawer();
        },
        label: Text('Scale'),
        icon: Icon(Icons.crop),
      ),
    );
  }
}
