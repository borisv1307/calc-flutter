import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/interactive_graph/graph_line_bounds.dart';

class BoundsDialog extends StatefulWidget{
  final GraphLineBounds bounds;

  BoundsDialog(this.bounds);

  @override
  State<StatefulWidget> createState() => BoundsDialogState();
}

class BoundsDialogState extends State<BoundsDialog>{


  Row _buildInput(String label, int initialValue, Function(String) onFieldSubmitted){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Text(label),
        ),
        Flexible(child:TextFormField(
          keyboardType: TextInputType.number,
          initialValue: '${initialValue ?? ''}',
          onFieldSubmitted: onFieldSubmitted,
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Segment bounds'),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          _buildInput('X min',this.widget.bounds.xMin,(String input){
            this.widget.bounds.xMin = input.isNotEmpty ? int.parse(input) : null;
          }),
          _buildInput('X max',this.widget.bounds.xMax,(String input){
            this.widget.bounds.xMax = input.isNotEmpty ? int.parse(input) : null;
          }),
          _buildInput('Y min',this.widget.bounds.yMin,(String input){
            this.widget.bounds.yMin = input.isNotEmpty ? int.parse(input) : null;
          }),
          _buildInput('Y max',this.widget.bounds.yMax,(String input){
            this.widget.bounds.yMax = input.isNotEmpty ? int.parse(input) : null;
          }),
        ]
      ),
      actions:[
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Close'))
      ]
    );
  }
}