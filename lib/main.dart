import 'package:flutter/material.dart';
import 'package:open_calc/home_screen.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  print('running');
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final settingsController = SettingsController(prefs);
  runApp(MyApp(settingsController));
}

class MyApp extends StatelessWidget {
  final SettingsController settingsController;

  MyApp(this.settingsController, {Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (context, _) {
        // inherited widget provides SettingsController to all pages
        return SettingsControllerProvider(
          controller: settingsController,
          child: HomeScreen(title: 'Graphing Calculator'),
        );
      },
    );
  }
}

