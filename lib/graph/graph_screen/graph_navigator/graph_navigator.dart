import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/cursor_direction.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/cursor_movement_calculator.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle/text_toggle_selection.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle/text_toggle_selector.dart';

class GraphNavigator extends StatelessWidget {
  final GraphCursor cursorDetails;
  final TextToggleSelection selection;
  final ScaleSettings scaleSettings;
  final CursorMovementCalculator cursorMovementCalculator;

  GraphNavigator(this.cursorDetails, this.selection, this.scaleSettings,{CursorMovementCalculator cursorMovementCalculator}):
      this.cursorMovementCalculator = cursorMovementCalculator ?? CursorMovementCalculator();


  Widget _buildArrow(CursorDirection direction, IconData iconData){
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            this.cursorDetails.location = cursorMovementCalculator.calculateMove(this.cursorDetails.location, direction, scaleSettings.step);
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