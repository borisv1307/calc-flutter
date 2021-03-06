import 'package:advanced_calculation/angular_unit.dart';
import 'package:advanced_calculation/calculation_options.dart';
import 'package:advanced_calculation/display_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/settings/settings_controller.dart';

class ModeDialog extends StatefulWidget{
  final CalculationOptions options;

  ModeDialog(this.options);

  @override
  State<StatefulWidget> createState() => ModeDialogState();
}

class ModeDialogState extends State<ModeDialog>{

  Row _buildOption({String label, DropdownButton button}){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        button
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select options'),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          _buildOption(
              label:'Decimal places',
              button: DropdownButton<int>(
                value: this.widget.options.decimalPlaces,
                items:  Iterable<int>.generate(11).map((number) {
                    return DropdownMenuItem<int>(
                        value: number - 1,
                        child: Text(number == 0 ? 'max' : (number - 1).toString())
                    );
                  }).toList(),
                onChanged: (int updated) async {
                    SettingsController.of(context).setDecimals(updated);
                    setState(() {
                      this.widget.options.decimalPlaces = updated;
                    });
                  }
              )
          ),
          _buildOption(
            label:'Angular unit',
            button: DropdownButton<AngularUnit>(
              value: this.widget.options.angularUnit,
              items:  [
                DropdownMenuItem<AngularUnit>(
                  value: AngularUnit.RADIAN,
                  child: Text('radian')
                ),
                DropdownMenuItem<AngularUnit>(
                    value: AngularUnit.DEGREE,
                    child: Text('degree')
                )
              ],
              onChanged: (AngularUnit updated) async {
                SettingsController.of(context).setAngular(updated);
                setState(() {
                  this.widget.options.angularUnit = updated;
                });
              }
            )
          ),
          _buildOption(
              label:'Display style',
              button: DropdownButton<DisplayStyle>(
                  value: this.widget.options.displayStyle,
                  items:  [
                    DropdownMenuItem<DisplayStyle>(
                        value: DisplayStyle.NORMAL,
                        child: Text('normal')
                    ),
                    DropdownMenuItem<DisplayStyle>(
                        value: DisplayStyle.SCIENTIFIC,
                        child: Text('scientific')
                    ),
                    DropdownMenuItem<DisplayStyle>(
                        value: DisplayStyle.ENGINEERING,
                        child: Text('engineering')
                    ),
                  ],
                  onChanged: (DisplayStyle updated) async {
                    SettingsController.of(context).setDisplayStyle(updated);
                    setState(() {
                      this.widget.options.displayStyle = updated;
                    });
                  }
              )
          ),
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