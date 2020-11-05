import 'dart:developer';

import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/bridge/graph_bridge.dart';

class GraphScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GraphScreenState();
}

class GraphScreenState extends State<GraphScreen>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaleFormKey = GlobalKey<FormState>();
  final _exprFormKey = GlobalKey<FormFieldState>();

  // Scale Value, Range and Domain of x and y will be set and saved in these variable
  int _xMin = -100,
      _xMax = 100,
      _yMin = -80,
      _yMax = 80,
      _xScl = 1,
      _yScl = 2,
      _xRes = 1;

  int width = 270,
    height = 162;
       
  GraphBridge bridge = GraphBridge();
  Coordinates cursorLocation = Coordinates(50, 50);
  String _y1 = "0.05 * x^2 - 50";
  List<Coordinates> coordinates;

  @override
  void initState() {
    super.initState();
    this._updateCoordinates();
  }

  void _updateCoordinates() {
    setState(() {
      coordinates = bridge.retrieveGraph(
          _y1, (width / 2) * -1, (width / 2), (height / 2) * -1, (height / 2));
    });
  }
  
  List<Coordinates> _getCoordinates() {
    return coordinates;
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

  void _openDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      decoration: InputDecoration(labelText: 'Y min:'),
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
                        _scaleFormKey.currentState.save();
                        _updateCoordinates();
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
                  coordinates: _getCoordinates(),
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
                  key: _exprFormKey,
                  decoration: InputDecoration(labelText: 'y = '),
                  onSaved: (input) => {
                    _y1 = input
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    _exprFormKey.currentState.save();
                    _updateCoordinates();
                  },
                  child: Text("Generate Graph")
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
          Container(
            margin: EdgeInsets.only(left: 35),
            child: FloatingActionButton.extended(
            
            backgroundColor: Colors.green,
            label: Text('Table'),
            icon: Icon(Icons.menu_book),
            heroTag: 1,
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 500,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Center(child: Container(
                            padding: EdgeInsets.fromLTRB(25,8,8,8),
                            // color: Colors.blue[200],
                            height: 60,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: ListTile(
                                    title: Text("x", style: TextStyle(fontSize: 24))
                                  ),
                                ),
                                Flexible(
                                  child: ListTile(
                                    title: Text("y₁", style: TextStyle(fontSize: 24))
                                  ),
                                ),
                                Flexible(
                                  child: ListTile(
                                    title: Text("y₂", style: TextStyle(fontSize: 24))
                                  ),
                                ),
                                Flexible(
                                  child: ListTile(
                                    title: Text("y₃", style: TextStyle(fontSize: 24))
                                  ),
                                ),
                                
                            ])
                          )),
                          Divider(thickness: 1.5),
                          Expanded(
                            child: Container(
                              child: ListView.separated(
                                // controller: ScrollController(initialScrollOffset: 135*72.1),
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(8),
                                itemCount: coordinates.length,
                                itemBuilder: (context, int index) {
                                  return Row(
                                    children: <Widget>[
                                      Flexible(
                                        // height: 20, width 30,
                                        child: ListTile(
                                          title: Text('${coordinates[index].x.toInt()}', style: TextStyle(fontSize: 20))
                                        ),
                                      ),
                                      Flexible(
                                        // height: 20, width 30,
                                        child: ListTile(
                                          title: Text('${coordinates[index].y}', style: TextStyle(fontSize: 20))
                                        ),
                                      ),
                                      Spacer(flex: 2)
                                  ]); 
                                },
                                separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1.5),
                              ))),
                          ElevatedButton(
                            child: const Text('Close Table'),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ),
                    ),
                  );
                });
            },
          )),
          FloatingActionButton.extended(
            onPressed: () {
              _openDrawer();
            },
            label: Text('Scale'),
            icon: Icon(Icons.crop),
            heroTag: 2
          ),
        ],
      )
    );
  }

}