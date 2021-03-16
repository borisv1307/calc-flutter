import 'package:flutter/material.dart';
import 'package:open_calc/settings/settings_controller.dart';

class ThemeDialog extends StatelessWidget {
  Widget _tileBuilder( BuildContext context, String themeName, Color primary, Color secondary) {
    return ListTile(
      selected: themeName == SettingsController.of(context).currentTheme,
      leading: Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: primary,
            child: CircleAvatar(
              backgroundColor: secondary,
              radius: 10,
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: themeName == SettingsController.of(context).currentTheme ? 1 : 0,
            child: CircleAvatar(
              backgroundColor: Color(0x669E9E9E),
              child: Icon(Icons.check, color: Colors.white),
            ),
          ),
        ],
      ),
      title: Text(_capitalize(themeName), style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
      onTap: () {
        SettingsController.of(context).setTheme(themeName);
        // Navigator.pop(context);
      }
    );
  }
    
  String _capitalize(String s) {
    if (s.length == 1) {
      return s.toUpperCase();
    } else {
      return s[0].toUpperCase() + s.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Select a theme'),
      children: <Widget>[
        _tileBuilder(context, 'default', Colors.blue, Colors.blue),
        _tileBuilder(context, 'orange', Colors.deepOrange, Colors.deepOrange),
        _tileBuilder(context, 'midnight', Color(0xFF1A2C42), Color(0xFF1A2C42)),
        _tileBuilder(context, 'dark', Colors.grey[900], Colors.grey[900]),
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
   