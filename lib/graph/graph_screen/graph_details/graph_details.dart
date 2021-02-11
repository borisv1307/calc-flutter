import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/equation_selector/equation_selector.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings_section.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle_selection.dart';
import 'package:open_calc/graph/graph_screen/graph_table.dart';

class GraphDetails extends StatefulWidget {
  final TextToggleSelection selection;
  final List<String> inputEquations;
  final int selectedIndex;
  final Function(int) traceEquation;
  final ScaleSettings scaleSettings;
  final GraphCursor graphCursor;
  final Function(String, double) calculateEquation;

  GraphDetails(this.inputEquations, this.selectedIndex, this.traceEquation, this.selection, this.scaleSettings,this.graphCursor, this.calculateEquation);

  @override
  State<StatefulWidget> createState() => GraphDetailsState();

}
class GraphDetailsState extends State<GraphDetails>{

  void _updateRoute(){
    setState(() {

    });
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
    int index = 0;
    if(this.widget.selection.selected == 'table')
      index = 1;
    if(this.widget.selection.selected == 'scale')
      index = 2;
      
    return Expanded(
      child:IndexedStack(
          index: index,
          children: <Widget>[
            EquationSelector(this.widget.inputEquations, this.widget.selectedIndex, this.widget.traceEquation),
            GraphTable(this.widget.inputEquations, this.widget.scaleSettings, this.widget.calculateEquation),
            ScaleSettingsSection(this.widget.scaleSettings, this.widget.graphCursor)
          ],
      )
    );
  }

}