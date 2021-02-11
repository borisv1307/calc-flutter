import 'package:flutter/material.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/interactive_graph.dart';


class GraphTable extends StatelessWidget {

  GraphTable({this.coordinates = const []});

  final List<List<Coordinates>> coordinates;

  @override
  Widget build(BuildContext context) {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    double screenHeight = MediaQuery.of(context).size.height * devicePixelRatio;
    double appBarHeight = Scaffold.of(context).appBarMaxHeight * devicePixelRatio;
    double tableHeight = (screenHeight - (InteractiveGraphState.GRAPH_HEIGHT + appBarHeight)) / devicePixelRatio;
    
    
    return Stack(
      children: <Widget>[
        Container(
          height: tableHeight,
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

                        for (int i = 0; i < coordinates.length; i++) {
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
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width - 118,
          top: tableHeight - 60,
          child: ElevatedButton.icon(
            label: Text("Back"),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              padding: EdgeInsets.all(10.0),
              primary: Colors.red,
              minimumSize: Size(103, 47.5),
              textStyle: TextStyle(
                letterSpacing: 1,
                fontSize: 15, 
                fontWeight: FontWeight.w500
              )
            ),
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          )
        )
      ]
    );
  }
}
