import 'package:flutter/material.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/interactive_graph.dart';


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
      for (int i = 0; i < widget.equations.length; i++) {
        List<Coordinates> coords = [];
        for (double x = widget.scaleSettings.xMin.toDouble(); x <= widget.scaleSettings.xMax; x += widget.scaleSettings.step) {
          double y = widget.calculateEquation(widget.equations[i], x);
          coords.add(Coordinates(x, y));
        }
        coordinates.add(coords);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  itemCount: coordinates[0].length,
                  itemBuilder: (context, int index) {
                    List<Widget> row = [];
                    row.add(Flexible(
                      child: ListTile(
                        title: Text('${coordinates[0][index].x.toInt()}', style: TextStyle(fontSize: 20))
                      ),
                    ));

                    for (int i = 0; i < coordinates.length && i < 3; i++) {
                      row.add(Flexible(
                        child: ListTile(
                          title: Text('${coordinates[i][index].y}', style: TextStyle(fontSize: 20))
                        ),
                      ));
                    }

                    if (coordinates.length == 1) 
                      row.add(Spacer(flex: 2));
                    if (coordinates.length == 2) 
                      row.add(Spacer(flex: 1));

                    return Row(
                      children: row
                    ); 
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1.5),
                )
              )
            ),
          ],
        ),
      )
    );
  }
}
