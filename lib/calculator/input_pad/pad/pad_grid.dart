
import 'package:flutter/material.dart';

class PadGrid extends StatelessWidget{
  final List<List<Widget>> buttons;

  PadGrid(this.buttons);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: buttons.map<Widget>((buttonRow)=>
              Expanded(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: buttonRow.map<Widget>((button)=> Expanded(child: button)).toList(),
                  )
              )
          ).toList()
      ),
    );
  }

}