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
  Coordinates cursorLocation = Coordinates(50,50);
  GraphBridge bridge = GraphBridge();
  int width = 270;
  int height = 162;

  List<Coordinates> _retrieveCoordinates(){
    List<Coordinates> allCoordinates = bridge.retrieve((width/2)*-1,(width/2),(height/2)*-1,(height/2));
    return allCoordinates;
  }

  void moveCursor(String direction){
    setState(() {
      double updatedX = cursorLocation.x;
      double updatedY = cursorLocation.y;
      if(direction == "UP"){
        updatedY += 3;
      }else if(direction == "DOWN"){
        updatedY -= 3;
      }else if(direction == "RIGHT"){
        updatedX += 3;
      }else if(direction == "LEFT"){
        updatedX -= 3;
      }
      this.cursorLocation = Coordinates(updatedX,updatedY);
    });
  }


  @override
  Widget build(BuildContext context) {

    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              CartesianGraph(
                Bounds(-135,135,-81,81),
                coordinates: _retrieveCoordinates(),
                cursorLocation: this.cursorLocation,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Column(
                children: [
                  InkWell(
                      onTap: (){
                        moveCursor('UP');
                      },
                    child: Icon(Icons.arrow_upward)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 25),
                          child:InkWell(
                              onTap: (){
                                moveCursor('LEFT');
                              },
                            child: Icon(Icons.arrow_back)
                          )
                      ),
                      InkWell(
                          onTap: (){
                            moveCursor('RIGHT');
                          },
                          child: Icon(Icons.arrow_forward)
                      )
                    ],
                  ),
                  InkWell(
                      onTap: (){
                        moveCursor('DOWN');
                      },
                      child: Icon(Icons.arrow_downward)
                  ),
                ],
              )]
            )
          ],
        ),
      ),
    );
  }
}