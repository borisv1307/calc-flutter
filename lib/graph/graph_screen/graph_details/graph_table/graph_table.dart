import 'package:flutter/material.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';


class GraphTable extends StatefulWidget {
  final List<String> equations;
  final ScaleSettings scaleSettings;
  final Function(String, double) calculateEquation;

  GraphTable(this.equations, this.scaleSettings, this.calculateEquation);

  @override
  State<StatefulWidget> createState() => GraphTableState();
}

class GraphTableState extends State<GraphTable> {
  List<List<Coordinates>> coordinates = [];
  int offset = 0;
  List<double> xValues;

  @override
  void initState() {
    _updateCoordinates();
    widget.scaleSettings.addListener(_updateCoordinates);
    super.initState();
  }

  @override
  void didUpdateWidget(GraphTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(oldWidget.scaleSettings != widget.scaleSettings) {
      oldWidget.scaleSettings.removeListener(_updateCoordinates);
      widget.scaleSettings.addListener(_updateCoordinates);
    }
  }

  @override
  void dispose(){
    widget.scaleSettings.removeListener(_updateCoordinates);
    super.dispose();
  }

  void _updateCoordinates() {
    setState(() {
      coordinates = [];
      for (int i = offset; i < widget.equations.length; i++) {
        List<Coordinates> coords = [];
        for (double x = widget.scaleSettings.xMin.toDouble(); x <= widget.scaleSettings.xMax; x += widget.scaleSettings.step) {
          double y = widget.calculateEquation(widget.equations[i], x);
          coords.add(Coordinates(x, y));
        }
        coordinates.add(coords);
      }
      if (coordinates.length > 0)
        _updateXValues();
    });
  }

  void _updateXValues() {
    xValues = coordinates[0].map((e) => e.x).toList();
  }

  String parseNumber(double n) {
    if (n % 1 == 0)
      return n.toInt().toString();
    else
      return n.toString();
  }

  String subscript(int value) {
    if (value < 10) {
      return String.fromCharCode(8320 + value);
    } else {
      return String.fromCharCode(8320 + (value / 10).floor()) + String.fromCharCode(8320 + (value % 10).floor());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool showLeftArrow = (offset > 0) ? true : false;

    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(child: Container(
                  padding: EdgeInsets.only(left: 3.0),
                  height: 56,
                  color: Colors.grey[300],
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          width: 70 - 3.0,
                          child: Center(child: Text("x", style: TextStyle(fontSize: 24))),
                        ),
                      ),
                      Container(height: 56, child: VerticalDivider(color: Colors.black54, width: 2)),
                      Flexible(
                        child: ListTile(
                          title: Center(child: Text("y" + subscript(offset + 1), style: TextStyle(fontSize: 24))),
                          contentPadding: EdgeInsets.only(bottom: 9)
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Center(child: Text("y" + subscript(offset + 2), style: TextStyle(fontSize: 24))),
                          contentPadding: EdgeInsets.only(bottom: 9)
                        ),
                      ),
                      Flexible(
                        child: ListTile(
                          title: Center(child: Text("y" + subscript(offset + 3), style: TextStyle(fontSize: 24))),
                          contentPadding: EdgeInsets.only(bottom: 9)
                        ),
                      ),
                    ]
                  )
                )),
                Divider(color: Colors.black38, thickness: 1, height: 1),
                Expanded(
                  child: Container(
                    child: ListView.separated(
                      // controller: ScrollController(initialScrollOffset: 135*72.1),
                      shrinkWrap: true,
                      itemCount: xValues.length,
                      itemBuilder: (context, int index) {
                        List<Widget> row = [];
                        row.add(Flexible(
                          child: Container(
                            width: 70,
                            child: Center(child: Text('${parseNumber(xValues[index])}',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            color: Colors.grey[300],
                            height: 56
                          ),
                        ));

                        row.add(Container(height: 56, child: VerticalDivider(color: Colors.black, width: 2)));
                        
                        for (int i = 0; i < coordinates.length && i < 3; i++) {
                          row.add(Flexible(
                            child: ListTile(
                              title: Center(child: Text('${parseNumber(coordinates[i][index].y)}', style: TextStyle(fontSize: 20),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              ))
                            ),
                          ));
                        }

                        if (coordinates.length == 1) 
                          row.add(Spacer(flex: 2));
                        if (coordinates.length == 2) 
                          row.add(Spacer(flex: 1));
                        if (coordinates.length == 0) 
                          row.add(Spacer(flex: 3));

                        return Row(
                          children: row
                        ); 
                      },
                      separatorBuilder: (BuildContext context, int index) => Divider(thickness: 2, height: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Opacity(
                  opacity: 0.4,
                  child: Material(
                    color: Colors.transparent,
                    child: !showLeftArrow ? null : InkWell(
                      onTap: () {
                        setState(() {
                          offset -= 1;
                          _updateCoordinates();
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_left, size: 36)
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.4,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          offset += 1;
                          _updateCoordinates();
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_right, size: 36)
                    ),
                  ),
                ),
              ]
            )
          ),
        ],
      ),
    );
  }
}

