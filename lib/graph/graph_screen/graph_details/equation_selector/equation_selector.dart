import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EquationSelector extends StatelessWidget{

  final List<String> inputEquations;
  final int selectedIndex;
  final Function(int) traceEquation;
  final TextStyle mainStyle = TextStyle(fontFamily: 'RobotoMono', fontSize: 18);



  EquationSelector(this.inputEquations, this.selectedIndex, this.traceEquation);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child:
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          //padding: const EdgeInsets.all(8),
          itemCount: inputEquations.length + 1,
          itemBuilder: (context, int index) {
            if (index == inputEquations.length) {
              return ListTile();
            }
            return ListTileTheme(
                selectedColor: Colors.black,
                selectedTileColor: Colors.green[100],
                child: ListTile(
                    leading: Text("y"+ (index+1).toString() + "=", style: mainStyle),
                    title: Text(inputEquations[index], style: mainStyle),
                    selected: index == selectedIndex,
                    onTap: () {
                      traceEquation(index);
                    }
                )
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(thickness: 1.5),
        ),
      );
  }
  
}