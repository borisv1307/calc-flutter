import 'package:flutter/material.dart';
import 'package:cartesian_graph/coordinates.dart';


class GraphTable extends StatelessWidget {

  GraphTable({this.coordinates = const []});
  final List<Coordinates> coordinates;

  @override
  Widget build(BuildContext context) {
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
  }
}
