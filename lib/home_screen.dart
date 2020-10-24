import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/bridge/graph_bridge.dart';
import 'package:open_calc/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator_display/display_history.dart';
import 'package:open_calc/input_pad/input_pad.dart';
import 'package:open_calc/input_validation/validate_function.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Coordinates cursorLocation = Coordinates(50, 50);
  GraphBridge bridge = GraphBridge();
  List<DisplayHistory> history = [];
  int width = 270;
  int height = 162;

  List<Coordinates> _retrieveCoordinates() {
    List<Coordinates> allCoordinates = bridge.retrieveGraph(
        (width / 2) * -1, (width / 2), (height / 2) * -1, (height / 2));
    return allCoordinates;
  }

  ValidateFunction tester = new ValidateFunction();

  void moveCursor(String direction) {
    setState(() {
      double updatedX = cursorLocation.x;
      double updatedY = cursorLocation.y;
      if (direction == "UP") {
        updatedY += 3;
      } else if (direction == "DOWN") {
        updatedY -= 3;
      } else if (direction == "RIGHT") {
        updatedX += 3;
      } else if (direction == "LEFT") {
        updatedX -= 3;
      }
      this.cursorLocation = Coordinates(updatedX, updatedY);
    });
  }

  String userInputString = '';

  void setLabelInput(String keypadInput) {
    setState(() {
        userInputString = (userInputString + keypadInput);
    });
  }

  void executeCommand(String command){
    if(command == 'enter'){
      collectInput(userInputString);
    }else if(command =='del'){
      setState(() {
        userInputString = userInputString.substring(0,userInputString.length-1);
      });
    }else if(command =='clear'){
      setState(() {
        userInputString = '';
        history=[];
      });
    }
  }


  //evaluates a function and adds the input to the history
  void collectInput(String expression) {
    String results;
    if (tester.testFunction(expression)) {
      results = bridge.retrieveCalculatorResult(expression);  // call to backend evaluator
    } else {
      results = "Syntax Error";
    }
    DisplayHistory newEntry = new DisplayHistory(expression, results);
    setState(() {
      userInputString = '';
    });

    history.add(newEntry);

  }

  @override
  Widget build(BuildContext context) {
    // than having to individually change instances of widgets.
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.call_missed_outgoing)),
            Tab(text: "y="),
            Tab(icon: Icon(Icons.calculate)),
          ],
        )
      ),
    body: TabBarView(
        children: [
          //TAB1------------------------------------------------------------
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
              maxHeight: 652,
            ),
            child: CartesianGraph(
              Bounds(-135, 135, -81, 81),
              coordinates: _retrieveCoordinates(),
              cursorLocation: this.cursorLocation,
            ),
          ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Column(
                children: [
                  InkWell(
                      onTap: () {
                        moveCursor('UP');
                      },
                      child: Icon(Icons.arrow_upward)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: InkWell(
                              onTap: () {
                                moveCursor('LEFT');
                              },
                              child: Icon(Icons.arrow_back))),
                      InkWell(
                          onTap: () {
                            moveCursor('RIGHT');
                          },
                          child: Icon(Icons.arrow_forward))
                    ],
                  ),
                  InkWell(
                      onTap: () {
                        moveCursor('DOWN');
                      },
                      child: Icon(Icons.arrow_downward)),
                ],
              )
            ])
          ],
        ),

          //TAB2------------------------------------------------------------
        Column(),
          //TAB3------------------------------------------------------------
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          CalculatorDisplay(8,inputLine:userInputString,history:history),
          Expanded(child:InputPad(setLabelInput,executeCommand)),
        ],
        ),
      ]  
    )
    )
    )
  );
  }
}