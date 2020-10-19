import 'package:flutter/material.dart';
import 'package:open_calc/bridge/graph_bridge.dart';
import 'package:open_calc/cartesian_graph/bounds.dart';
import 'package:open_calc/cartesian_graph/cartesian_graph.dart';
import 'package:open_calc/cartesian_graph/coordinates.dart';

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
            top: Radius.circular(15), bottom: Radius.circular(15)),
        child: Container(
          width: 200,
          height: 470,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text('X min:')),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text('X max:')),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text('X scale:')),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text('Y min:')),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text('Y max:')),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text('Y scale:')),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(child: Text('X res:')),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: _closeDrawer,
                  child: Text("Save Changes"),
                ),
              ],
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
