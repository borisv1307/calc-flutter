import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle_selection.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle_selector.dart';

enum CursorDirection { UP, DOWN, LEFT, RIGHT }

class GraphNavigator extends StatefulWidget {
  final Function(Coordinates updatedLocation) moveCursor;
  final GraphCursor cursorDetails;
  final TextToggleSelection selection;
  final ScaleSettings scaleSettings;

  GraphNavigator(
      this.cursorDetails, this.moveCursor, this.selection, this.scaleSettings);

  @override
  _GraphNavigatorState createState() => _GraphNavigatorState();
}

class _GraphNavigatorState extends State<GraphNavigator> {
  final TextStyle mainStyle =
      TextStyle(fontFamily: 'RobotoMono', fontSize: 20, color: Colors.white);

  void _zoomIn() {
    setState(() {
      widget.scaleSettings.xMax--;
      widget.scaleSettings.yMax--;
      widget.scaleSettings.xMin++;
      widget.scaleSettings.yMin++;
    });
  }

  void _zoomOut() {
    setState(() {
      widget.scaleSettings.xMax++;
      widget.scaleSettings.yMax++;
      widget.scaleSettings.xMin--;
      widget.scaleSettings.yMin--;
    });
  }

  void _moveCursor(CursorDirection direction) {
    double updatedX = widget.cursorDetails.location.x;
    double updatedY = widget.cursorDetails.location.y;
    if (direction == CursorDirection.UP) {
      updatedY += widget.cursorDetails.step;
    } else if (direction == CursorDirection.DOWN) {
      updatedY -= widget.cursorDetails.step;
    } else if (direction == CursorDirection.RIGHT) {
      updatedX += widget.cursorDetails.step;
    } else if (direction == CursorDirection.LEFT) {
      updatedX -= widget.cursorDetails.step;
    }
    widget.moveCursor(Coordinates(updatedX, updatedY));
  }

  Widget _buildArrow(CursorDirection command, IconData iconData) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              this._moveCursor(command);
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
