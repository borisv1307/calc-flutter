import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:open_calc/bridge/graph_bridge.dart';
import 'package:open_calc/graph_display.dart';
import 'package:open_calc/pixel_map.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> cursorLocation = [50,50];
  GraphBridge bridge = GraphBridge();

  Future<ui.Image> _makeImage(){
    int width = 270;
    int height = 162;
    final c = Completer<ui.Image>();

    GraphDisplay display = GraphDisplay(width,height,4);
    display.displayLegend(cursorLocation);

    List<List<double>> points = bridge.retrieve((width/2)*-1,(width/2),(height/2)*-1,(height/2),1);
    print(points);
    for(List<double> coordinates in points){
      display.plotCoordinates(coordinates[0], coordinates[1], Colors.black);
    }

    display.render(c.complete);

    return c.future;
  }

  void moveCursor(String direction){
    setState(() {
      if(direction == "UP"){
        cursorLocation[1] += 3;
      }else if(direction == "DOWN"){
        cursorLocation[1] -= 3;
      }else if(direction == "RIGHT"){
        cursorLocation[0] += 3;
      }else if(direction == "LEFT"){
        cursorLocation[0] -= 3;
      }
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
              FutureBuilder<ui.Image>(
                future: _makeImage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RawImage(
                      image: snapshot.data,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
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