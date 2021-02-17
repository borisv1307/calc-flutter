import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle_selection.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle_selector.dart';

enum CursorDirection {
  UP,DOWN,LEFT,RIGHT
}
class GraphNavigator extends StatelessWidget {
  final GraphCursor cursorDetails;
  final TextToggleSelection selection;
  final ScaleSettings scaleSettings;

  GraphNavigator(this.cursorDetails, this.selection, this.scaleSettings);
  
  final TextStyle mainStyle = TextStyle(fontFamily: 'RobotoMono', fontSize: 20,color: Colors.white);

  void _moveCursor(CursorDirection direction){
    double updatedX = cursorDetails.location.x;
    double updatedY = cursorDetails.location.y;
    if (direction == CursorDirection.UP) {
      updatedY += scaleSettings.step;
    } else if (direction == CursorDirection.DOWN) {
      updatedY -= scaleSettings.step;
    } else if (direction == CursorDirection.RIGHT) {
      updatedX += scaleSettings.step;
    } else if (direction == CursorDirection.LEFT) {
      updatedX -= scaleSettings.step;
    }
    this.cursorDetails.location = Coordinates(updatedX, updatedY);
  }

  Widget _buildArrow(CursorDirection command, IconData iconData){
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            this._moveCursor(command);
          },
          child: Icon(iconData,color:Colors.black)
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: TextToggleSelector(selection)),
          Column(
              children: [
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
              ]
          )
        ],
      ),
    );
  }

}