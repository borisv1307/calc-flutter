import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/equation_selector/bounds_dialog.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_lines.dart';

class EquationSelector extends StatefulWidget {
  final GraphLines inputEquations;
  final GraphCursor cursor;

  EquationSelector(this.inputEquations, this.cursor);

  @override
  State<StatefulWidget> createState() => EquationSelectorState();
}

class EquationSelectorState extends State<EquationSelector> {
  final TextStyle mainStyle = TextStyle(fontFamily: 'RobotoMono', fontSize: 22);
  int selectedIndex = -1;

  void _traceEquation(int index) {
    setState(() {
      if (selectedIndex == index) {
        // exit trace mode
        selectedIndex = -1;
        this.widget.cursor.color = Colors.blue;
        this.widget.cursor.equation = null;
        this.widget.inputEquations[index].color = Colors.black;
      } else {
        selectedIndex = index;
        this.widget.cursor.color = Colors.red;
        this.widget.cursor.equation =
            this.widget.inputEquations[selectedIndex].equation;
        this.widget.inputEquations[index].color = Colors.blue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        //padding: const EdgeInsets.all(8),
        itemCount: this.widget.inputEquations.length + 1,
        itemBuilder: (context, int index) {
          if (index == this.widget.inputEquations.length) {
            return ListTile();
          }
          return ListTileTheme(
              selectedColor: Colors.black,
              selectedTileColor: Colors.green[100],
              child: ListTile(
                leading:
                    Text("y" + (index + 1).toString() + "=", style: mainStyle),
                title: Text(this.widget.inputEquations[index].equation,
                    style: mainStyle),
                selected: index == selectedIndex,
                onTap: () {
                  _traceEquation(index);
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return BoundsDialog(
                            this.widget.inputEquations[index].segmentBounds);
                      });
                },
              ));
        },
        separatorBuilder: (BuildContext context, int index) =>
            Divider(thickness: 1.5),
      ),
    );
  }
}
