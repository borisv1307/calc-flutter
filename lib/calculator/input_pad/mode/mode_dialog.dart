import 'package:advanced_calculation/calculation_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/settings/settings_controller.dart';

class ModeDialog extends StatefulWidget{
  final CalculationOptions options;

  ModeDialog([CalculationOptions options]) :
    this.options = options ?? CalculationOptions();

  @override
  State<StatefulWidget> createState() => ModeDialogState(options);
}

class ModeDialogState extends State<ModeDialog>{
  final CalculationOptions options;

  ModeDialogState(this.options);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    options.decimalPlaces = SettingsController.of(context).decimalPlaces;
    options.angularUnit = SettingsController.of(context).angularUnit;
  }

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
                value: options.decimalPlaces,
                items:  Iterable<int>.generate(11).map((number) {
                    return DropdownMenuItem<int>(
                        value: number - 1,
                        child: Text(number == 0 ? 'max' : (number - 1).toString())
                    );
                  }).toList(),
                onChanged: (int updated) async {
                    await SettingsController.of(context).setDecimals(updated);
                    setState(() {
                      options.decimalPlaces = SettingsController.of(context).decimalPlaces;
                    });
                  }
              )
          ),
          _buildOption(
            label:'Angular unit',
            button: DropdownButton<AngularUnit>(
              value: options.angularUnit,
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
                await SettingsController.of(context).setAngular(updated);
                setState(() {
                  options.angularUnit = SettingsController.of(context).angularUnit;
                });
              }
            )
          ),
        ]
      ),
      actions:[
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Close'))
      ]
    );
  }
}