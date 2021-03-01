import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_navigator/text_toggle/text_toggle_selection.dart';

class TextToggleSelector extends StatefulWidget {
  final TextToggleSelection selection;

  TextToggleSelector(this.selection);

  @override
  State<StatefulWidget> createState() => TextToggleSelectorState();
}

class TextToggleSelectorState extends State<TextToggleSelector>{


  Widget _buildSelection(String display){
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: display == this.widget.selection.selected ? Colors.blue : Colors.transparent,
        child:InkWell(
            splashColor: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child:Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(display,style: TextStyle(color: display == this.widget.selection.selected ? Colors.white : Colors.black,fontWeight: FontWeight.bold),),
            ),
            onTap: (){
              setState(() {
                this.widget.selection.selected = display;
              });
            }
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['equations','table','scale'].map((item){
                return _buildSelection(item);
              }).toList()
          )
        ]
    );
  }

}