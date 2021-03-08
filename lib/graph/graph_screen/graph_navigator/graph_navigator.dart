import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/cursor_direction.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/cursor_movement_calculator.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle/text_toggle_selection.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle/text_toggle_selector.dart';

class GraphNavigator extends StatefulWidget {
  final GraphCursor cursorDetails;
  final TextToggleSelection selection;
  final ScaleSettings scaleSettings;

  GraphNavigator(this.cursorDetails, this.selection, this.scaleSettings);

  final TextStyle mainStyle =
      TextStyle(fontFamily: 'RobotoMono', fontSize: 20, color: Colors.white);
  @override
  _GraphNavigatorState createState() => _GraphNavigatorState();
}

class _GraphNavigatorState extends State<GraphNavigator> {
  final TextStyle mainStyle =
      TextStyle(fontFamily: 'RobotoMono', fontSize: 20, color: Colors.white);
  CursorMovementCalculator _movementCalculator = CursorMovementCalculator();

  void _zoomIn() {
    setState(() {
      this.widget.scaleSettings.xMax--;
      this.widget.scaleSettings.yMax--;
      this.widget.scaleSettings.xMin++;
      this.widget.scaleSettings.yMin++;
    });
  }

  void _zoomOut() {
    setState(() {
      this.widget.scaleSettings.xMax++;
      this.widget.scaleSettings.yMax++;
      this.widget.scaleSettings.xMin--;
      this.widget.scaleSettings.yMin--;
    });
  }

  Widget _buildArrow(CursorDirection command, IconData iconData) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              widget.cursorDetails.location = _movementCalculator.calculateMove(
                  widget.cursorDetails.location,
                  command,
                  widget.scaleSettings.step);
            },
            child: Icon(iconData, color: Colors.black)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: TextToggleSelector(widget.selection)),
          Column(children: [
            _buildArrow(CursorDirection.UP, Icons.arrow_upward),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: _buildArrow(CursorDirection.LEFT, Icons.arrow_back),
                ),
                _buildArrow(CursorDirection.RIGHT, Icons.arrow_forward),
              ],
            ),
            _buildArrow(CursorDirection.DOWN, Icons.arrow_downward),
          ]),
          Container(
              width: 40,
              child: Column(
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          _zoomIn();
                        },
                        child: Icon(
                          Icons.zoom_in,
                          size: 36,
                        )),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          _zoomOut();
                        },
                        child: Icon(
                          Icons.zoom_out,
                          size: 36,
                        )),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
