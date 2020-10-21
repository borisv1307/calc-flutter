import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/bridge/graph_bridge.dart';
import 'package:open_calc/calculator_display/calculator_display.dart';
import 'package:open_calc/calculator_display/display_history.dart';
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
    List<Coordinates> allCoordinates = bridge.retrieve(
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

  void setLabelInput(String keypadInput){
    setState(() {
      if(keypadInput == "C"){
        userInputString = '';
      }else{
        userInputString = (userInputString + keypadInput);
      }
    });
  }

  //evaluates a function and adds the input to the history
  void collectInput(String string) {

    //temporary results until merge with backend
    String results = (tester.testFunction(string)).toString();
    DisplayHistory newEntry = new DisplayHistory(string, results);
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
            SizedBox(
              height:652/MediaQuery.of(context).devicePixelRatio,
              child: CalculatorDisplay(userInputString,history),
            ),
          Expanded(
            flex: 5,
            child: DefaultTabController(length: 3, 
              child: Scaffold(appBar: PreferredSize( preferredSize: Size.fromHeight(50.0),
                child: AppBar(bottom: TabBar(tabs: [
                  Tab(text: 'Basic'),
                  Tab(text: 'TBD'),
                  Tab(text: 'TBD'),
              ],),),),
              body: TabBarView(children: [
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: Row(children: [
                  Expanded(
                    flex:20,
                    child:
                  Column(
                      children: [
                        InkWell(
                          child: Text('  (  ', style: TextStyle(fontSize:40,)),
                          onTap: (){setLabelInput('(');}
                        ),
                        InkWell(
                          child: Text('  1  ', style: TextStyle(fontSize:40,)),
                          onTap: (){setLabelInput('1');}
                        ),
                        InkWell(
                          child: Text('  4  ', style: TextStyle(fontSize:40,)),
                          onTap: (){setLabelInput('4');}
                        ),
                        InkWell(
                          child: Text('  7  ', style: TextStyle(fontSize:40,)),
                          onTap: (){setLabelInput('7');}
                        ),
                        InkWell(
                          child: Text(' +/- ', style: TextStyle(fontSize:40,)),
                          onTap: (){setLabelInput('1');}
                        )
                      ],
                  )),
                  Expanded(
                    flex:20,
                    child:
                  Column(children: [
                      InkWell(
                        child: Text('  )  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput(')');}
                      ),
                      InkWell(
                        child: Text('  2  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('2');}
                      ),
                      InkWell(
                        child: Text('  5  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('5');}
                      ),
                      InkWell(
                        child: Text('  8  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('8');}
                      ),
                      InkWell(
                        child: Text('  0  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('0');}
                      )
                  ],
                  )),
                  Expanded(
                    flex:20,
                    child:
                  Column(children: [
                      InkWell(
                        child: Text('  C  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('C');}
                      ),
                      InkWell(
                        child: Text('  3  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('3');}
                      ),
                      InkWell(
                        child: Text('  6  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('6');}
                      ),
                      InkWell(
                        child: Text('  9  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('9');}
                      ),
                      InkWell(
                        child: Text('  .  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('.');}
                      )
                  ],
                  )),
                  Expanded(
                    flex:20,
                    child:
                  Column(children: [
                      InkWell(
                        child: Text('  /  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('/');}
                      ),
                      InkWell(
                        child: Text('  x  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('*');}
                      ),
                      InkWell(
                        child: Text('  -  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('-');}
                      ),
                      InkWell(
                        child: Text('  +  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('+');}
                      ),
                      InkWell(
                        child: Text('  =  ', style: TextStyle(fontSize:40,)),
                        onTap: (){collectInput(userInputString);}
                      )
                  ],
                  )),
                  Expanded(
                    flex:20,
                    child:
                  Column(children: [
                      InkWell(
                        child: Text('  ^  ', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('^');}
                      ),
                      InkWell(
                        child: Text('log(', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('log(');}
                      ),
                      InkWell(
                        child: Text('ln(', style: TextStyle(fontSize:40,)),
                        onTap: (){setLabelInput('ln(');}
                      ),
                  ],
                  )),
                  ] 
                  )
                  )
                ]
                ),
                Row(),
                Row(),
              ],)
              ),
            )                          
        ),
        ],
        ),
      ]  
    )
    )
    )
  );
  }
}