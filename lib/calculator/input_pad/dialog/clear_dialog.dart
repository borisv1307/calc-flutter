import 'package:flutter/material.dart';
import 'package:open_calc/settings/settings_controller.dart';

class ClearDialog extends StatelessWidget{
  final Function clearHistory;

  ClearDialog(this.clearHistory);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        ListTile(
          title: Text('Clear History'),
          onTap: () {
            SettingsController.of(context).clearCalcHistory();
            this.clearHistory();
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Clear Variables'),
          onTap: () {
            SettingsController.of(context).setFunctionList([]);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Reset Memory'),
          onTap: () {
            SettingsController.of(context).reset();
            this.clearHistory();
            Navigator.pop(context);
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: Text('Close'), 
            style: TextButton.styleFrom(primary: Colors.blue)
          )
        )
      ],
    );
  }
}
