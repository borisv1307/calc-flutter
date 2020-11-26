import 'dart:async';
import 'dart:developer';

import 'package:cartesian_graph/bounds.dart';
import 'package:cartesian_graph/cartesian_graph.dart';
import 'package:cartesian_graph/coordinates.dart';
import 'package:open_calc/graph/graph_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GraphScreenState();
}
class FunctionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunctionScreenState();

}

String _y1 = "0.05 * x^2 - 50";
String _y2 = "x + 5";
String _y3 = "x^3";

class FunctionScreenState extends State<FunctionScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _functionController;
  static List<String> functionList = [null];

  @override
  void initState() {
    super.initState();
    _functionController = new TextEditingController(text: _y1);
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _functionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                Container(
                  height: 300,
                  margin: EdgeInsets.symmetric( vertical: 10, horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ..._getFunctions(),
                        ButtonTheme(
                          minWidth: 200.0,
                          height: 40,
                          child: RaisedButton(
                            onPressed: () {
                              // functionList.insert(functionList.length, null);
                              functionList.add(null);
                              setState((){});
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                // borderRadius: BorderRadius.circular(15),
                              ),
                              // onPressed: ,
                              child: Icon(
                                Icons.add, color: Colors.white,
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if(_formkey.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GraphScreen()),
                        );
                      }
                    },
                    child: Text("Generate Graph")
                ),
              ],
            ),
          ),
        )
    );
  }
  List<Widget> _getFunctions(){
    List<Widget> functionsTextFields = [];
    for (int i = 0; i < functionList.length; i++) {
      functionsTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(child: FunctionTextFields(i)),
                SizedBox(width: 16,),
                // we need add button at last friends row only
                _removeButton(false, i),
              ],
            ),
          )
      );
    }
    return functionsTextFields;
  }
  Widget _removeButton(bool add, int index) {
    return InkWell(
      onTap: (){
        // if(add){
        //   // add new text-fields at the top of all friends textfields
        //   functionList.insert(index + 1, null);
        // }
        // else
        functionList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          Icons.remove, color: Colors.white,
        ),
      ),
    );
  }
}

class FunctionTextFields extends StatefulWidget {
  final int index;
  FunctionTextFields(this.index);

  @override
  _FunctionTextFieldsState createState() => _FunctionTextFieldsState();
}

class _FunctionTextFieldsState extends State<FunctionTextFields> {
  TextEditingController _functionController;

  @override
  void initState() {
    super.initState();
    _functionController = TextEditingController();
  }
  @override
  void dispose() {
    _functionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _functionController.text = FunctionScreenState.functionList[widget.index]
          ?? '';
    });
    return TextFormField(
      controller: _functionController,
      // save text field data in friends list at index
      // whenever text field value changes
      onChanged: (v) => FunctionScreenState.functionList[widget.index] = v,
      decoration: InputDecoration(
          labelText: 'y' + (widget.index + 1).toString() + '= '
      ),
      validator: (v){
        if(v.trim().isEmpty) return 'Please enter something';
        return null;
      },
    );
  }
}



class GraphScreenState extends State<GraphScreen>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaleFormKey = GlobalKey<FormState>();
  final _exprFormKey = GlobalKey<FormFieldState>();
  FunctionScreenState functionScreenState;
  List<String> inputEquations = FunctionScreenState.functionList;

  // Scale Value, Range and Domain of x and y will be set and saved in these variable
  int _xMin = -100,
      _xMax = 100,
      _yMin = -80,
      _yMax = 80,
      _xScl = 1,
      _yScl = 2,
      _xRes = 1;

  int width = 270,
    height = 162;

  Coordinates cursorLocation = Coordinates(50, 50);
  // String _y1 = "0.05 * x^2 - 50";
  List<Coordinates> coordinates;

  @override
  void initState() {
    super.initState();
  }

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

  void _openDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Graph"),
        ),
      key: _scaffoldKey,
      endDrawer: ClipRRect(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
            bottom: Radius.circular(10)),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            width: 200,
            height: 485,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _scaleFormKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '$_xMax',
                      decoration:
                      InputDecoration(labelText: 'X max:'),
                      onSaved: (input) => {
                        _xMax = int.parse(input),
                        log('x_Max: ' + input)
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '$_xMin',
                      decoration:
                      InputDecoration(labelText: 'X min:'),
                      onSaved: (input) => {
                        _xMin = int.parse(input),
                        log('x_Min: ' + input)
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '$_xScl',
                      decoration:
                      InputDecoration(labelText: 'X scale:'),
                      onSaved: (input) => {
                        _xScl = int.parse(input),
                        log('x_Scl: ' + input)
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '$_yMax',
                      decoration:
                      InputDecoration(labelText: 'Y max:'),
                      onSaved: (input) => {
                        _yMax = int.parse(input),
                        log('y_Max: ' + input)
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '$_yMin',
                      decoration:
                      InputDecoration(labelText: 'Y min:'),
                      onSaved: (input) => {
                        _yMin = int.parse(input),
                        log('y_Min: ' + input)
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '$_yScl',
                      decoration:
                      InputDecoration(labelText: 'Y scale:'),
                      onSaved: (input) => {
                        _yScl = int.parse(input),
                        log('y_Min: ' + input)
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: '$_xRes',
                      decoration:
                      InputDecoration(labelText: 'X res:'),
                      onSaved: (input) => {
                        _xRes = int.parse(input),
                        log('x_Res: ' + input)
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _scaleFormKey.currentState.save();
                        setState(() {});
                      },
                      child: Text("Save Changes"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 652,
                ),
                child: CartesianGraph(
                  Bounds(_xMin, _xMax, _yMin, _yMax),
                  cursorLocation: this.cursorLocation,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("x = " + (cursorLocation.x - 180).toString()),
                      Text("y = " + (cursorLocation.y - 81).toString()),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                          onTap: () {
                            moveCursor('UP');
                          },
                          child: Icon(Icons.arrow_upward)),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
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
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 10, horizontal: 10),
            child: Column(
              children: <Widget>[
                ..._getEquations(),
                // Text("y1 = $_y1")
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 35),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.green,
              label: Text('Table'),
              icon: Icon(Icons.menu_book),
              heroTag: 1,
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return GraphTable(coordinates: this.coordinates);
                  }
                );
              })
          ),
          FloatingActionButton.extended(
            onPressed: () {
              _openDrawer();
            },
            label: Text('Scale'),
            icon: Icon(Icons.crop),
            heroTag: 2
          ),
        ],
      )
    );
  }
  List<Widget> _getEquations() {
    List<Widget> displayedEquations = [];
    for (int i = 0; i < inputEquations.length; i++) {
      log(inputEquations[i]);
      displayedEquations.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text("y"+ (i+1).toString() + " = " + inputEquations[i]),
          )
      );
    }
    return displayedEquations;
  }
}