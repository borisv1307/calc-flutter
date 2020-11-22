import 'package:flutter/material.dart';
import 'package:open_calc/calculator/calculator_screen.dart';
import 'package:open_calc/graph/graph_screen.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    VariableStorage storage = new VariableStorage();
    List<List<List<String>>> matrixStorage = new List<List<List<String>>>();

    return MaterialApp(
        home: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: Text(this.title),
                  actions: <Widget>[
                    Container(),
                  ],
                  bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.call_missed_outgoing)),
                      Tab(icon: Icon(Icons.calculate)),
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  GraphScreen(),
                  CalculatorScreen(storage, matrixStorage)
                ]
            )
        )
    ),
  );
  }
}