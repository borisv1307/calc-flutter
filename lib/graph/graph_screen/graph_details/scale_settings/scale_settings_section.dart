import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_cursor.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';

class ScaleSettingsSection extends StatelessWidget{

  final ScaleSettings scaleSettings;
  final GraphCursor graphCursor;

  ScaleSettingsSection(this.scaleSettings, this.graphCursor);

  Widget _buildFormField(String label, value, onFieldSubmitted){
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: '$value',
      decoration:
      InputDecoration(labelText: '$label'),
      onFieldSubmitted: onFieldSubmitted,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(child: Column(
            children: [
              _buildFormField('X min', scaleSettings.xMin,
                  (input){
                      scaleSettings.xMin = int.parse(input);
                  }),
              _buildFormField('X max', scaleSettings.xMax,
                      (input){
                    scaleSettings.xMax = int.parse(input);
                  }),
            ],
          ),),
          Expanded(child: Column(
            children: [
              _buildFormField('Y min', scaleSettings.yMin,
                (input){
                  scaleSettings.yMin = int.parse(input);
                }),
              _buildFormField('Y max', scaleSettings.yMax,
                  (input){
                  scaleSettings.yMax = int.parse(input);
                  }),
            ],
          )),
          Expanded(child: Column(
            children: [
              _buildFormField('step', scaleSettings.step,
                (input){
                  scaleSettings.step = double.parse(input);
                }),
            ],
          ),)
        ],
      ),
    );
  }

}