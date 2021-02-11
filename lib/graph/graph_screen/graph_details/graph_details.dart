import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_details/equation_selector/equation_selector.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle_selection.dart';

class GraphDetails extends StatefulWidget {
  final TextToggleSelection selection;
  final List<String> inputEquations;
  final int selectedIndex;
  final Function(int) traceEquation;

  GraphDetails(this.inputEquations, this.selectedIndex, this.traceEquation, this.selection);

  @override
  State<StatefulWidget> createState() => GraphDetailsState();

}
class GraphDetailsState extends State<GraphDetails>{

  void _updateRoute(){
    print(this.widget.selection.selected);

  }

  @override
  void initState() {
    super.initState();
    widget.selection.addListener(_updateRoute);
  }

  @override
  void didUpdateWidget(GraphDetails oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(oldWidget.selection != widget.selection) {
      oldWidget.selection.removeListener(_updateRoute);
      widget.selection.addListener(_updateRoute);
    }
  }

  @override
  void dispose(){
    widget.selection.removeListener(_updateRoute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:Navigator(
          pages:[
            MaterialPage(
                key: ValueKey('equations'),
                child: EquationSelector(this.widget.inputEquations, this.widget.selectedIndex, this.widget.traceEquation)
            )
          ],
          onPopPage: (route, result) => route.didPop(result)
      )
    );
  }

}