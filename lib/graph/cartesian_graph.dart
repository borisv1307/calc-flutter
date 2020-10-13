import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/coordinates.dart';
import 'dart:ui' as ui;
import 'dart:async';

import 'graph_display.dart';

class CartesianGraph extends StatelessWidget{
  final int width;
  final int height;
  final List<Coordinates> coordinates;
  final Coordinates cursorLocation;

  CartesianGraph({this.width,this.height, this.coordinates, this.cursorLocation});

  Future<ui.Image> _makeImage(){
    int width = 270;
    int height = 162;
    final c = Completer<ui.Image>();

    GraphDisplay display = GraphDisplay(width+1,height+1,4);
    display.displayLegend();
    if(cursorLocation != null){
      display.displayCursor(cursorLocation);
    }

    for(int i = 0; i< coordinates.length-1;i++){
      display.plotSegment(coordinates[i],coordinates[i+1], Colors.black);
    }

    display.render(c.complete);

    return c.future;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<ui.Image>(
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
        )
    );
  }

}