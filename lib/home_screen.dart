import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_tab.dart';
import 'package:open_calc/graph/graph_tab.dart';
import 'package:open_calc/settings/settings_controller.dart';
import 'package:open_calc/settings/theme_builder.dart';


class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{
  bool isCalculate = true;
  
  @override
  Widget build(BuildContext context) {
    isCalculate = SettingsController.of(context).isCalcScreen;

    return MaterialApp(
      theme: ThemeBuilder.buildTheme(SettingsController.of(context).currentTheme),
      darkTheme: ThemeBuilder.buildTheme('dark'),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(this.widget.title),
            actions: <Widget>[
              InkWell(
                child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(isCalculate ? Icons.call_missed_outgoing: Icons.calculate ),
                ),
                onTap: () async {
                  await SettingsController.of(context).setCalcScreen(!isCalculate);
                  setState(() {
                    isCalculate = !isCalculate;
                  });
                },
              )
            ],
          ),
          body: Navigator(
            pages:[
              MaterialPage(child: GraphTab()),
              if(isCalculate)
                MaterialPage(child: CalculatorTab())
            ],
            onPopPage: (route, result) => route.didPop(result),
          )
        )
      ),
    );
  }
}