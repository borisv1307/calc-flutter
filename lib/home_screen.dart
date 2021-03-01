import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_tab.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/graph_tab.dart';
import 'package:open_calc/settings/settings_controller.dart';


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
    VariableStorage storage = new VariableStorage();

    List<List<List<String>>> matrixStorage = new List<List<List<String>>>();
    Function(InputItem input) inputFunction; 

    isCalculate = SettingsController.of(context).isCalcScreen;


    return MaterialApp(
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
                    MaterialPage(child: GraphTab(storage)),
                    if(isCalculate)
                      MaterialPage(child: CalculatorTab(storage, matrixStorage, inputFunction))
                  ],
                  onPopPage: (route, result) => route.didPop(result),
                )
        )
    ),
  );
  }
}