import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModeDialog extends StatefulWidget{
  final CalculationOptions options;
  ModeDialog(this.options);

  @override
  State<StatefulWidget> createState() => ModeDialogState();

}

class ModeDialogState extends State<ModeDialog>{

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select options'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Decimal places'),
          DropdownButton(
              value: this.widget.options.decimalPlaces.toString(),
              items:  Iterable<int>.generate(11).map((number) {
                return DropdownMenuItem<String>(
                    value: (number - 1).toString(),
                    child: Text(number == 0 ? 'float' : (number - 1).toString())
                );
              }).toList(),
          onChanged: (String updated){
            setState(() {
              this.widget.options.decimalPlaces = int.parse(updated);
            });
          })
        ],
      ),
      actions:[
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Close'))
      ]
    );
  }
}