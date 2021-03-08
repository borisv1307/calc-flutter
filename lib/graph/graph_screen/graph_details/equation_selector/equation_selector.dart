import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_screen.dart';

class EquationSelector extends StatefulWidget {
  final List<String> inputEquations;
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
        GraphScreenState.chosenEquationIndex = -1;
        selectedIndex = -1;
        this.widget.cursor.color = Colors.blue;
        this.widget.cursor.equation = null;
      } else {
        GraphScreenState.chosenEquationIndex = index;
        selectedIndex = index;
        this.widget.cursor.color = Colors.red;
        this.widget.cursor.equation = this.widget.inputEquations[selectedIndex];
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
                  leading: Text("y" + (index + 1).toString() + "=",
                      style: mainStyle),
                  title:
                      Text(this.widget.inputEquations[index], style: mainStyle),
                  selected: index == selectedIndex,
                  onTap: () {
                    _traceEquation(index);
                  }));
        },
        separatorBuilder: (BuildContext context, int index) =>
            Divider(thickness: 1.5),
      ),
    );
  }
}
