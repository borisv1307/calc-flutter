import 'package:advanced_calculation/advanced_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_text_field.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/function_screen/input_pad/graph_input_handler.dart';
import 'package:open_calc/graph/function_screen/input_pad/graph_input_pad.dart';

class FunctionScreen extends StatefulWidget {
  final VariableStorage storage;
  final FunctionDisplayController controller;
  final AdvancedCalculator calculator;
  FunctionScreen(this.storage, this.controller, [this.calculator]);

  @override
  State<StatefulWidget> createState() => FunctionScreenState();
}

class FunctionScreenState extends State<FunctionScreen> {
  final _formKey = GlobalKey<FormState>();
  GraphInputHandler inputHandler;

  List<Widget> _getFunctions(){
    List<Widget> functions = [];
    for (int i = 0; i < widget.controller.inputs.length; i++) {
      functions.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              Text('y' + (i + 1).toString() + '=', style: TextStyle(fontFamily: 'RobotoMono', fontSize: 20)),
              SizedBox(width: 10),
              Expanded(child: FunctionTextField(i, widget.controller, widget.calculator)),
              SizedBox(width: 16,),
              // we need add button at last friends row only
              _removeButton(false, i),
            ],
          ),
        )
      );
    }
    return functions;
  }
  
  Widget _removeButton(bool add, int index) {
    return InkWell(
      onTap: (){
        setState((){
          widget.controller.removeField(index);
        });
      },
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          Icons.remove, color: Colors.white, size: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    inputHandler = GraphInputHandler(widget.controller, context, _formKey);

    return Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                        color: Color.fromRGBO(170, 200, 154, 1),
                        padding: EdgeInsets.symmetric( vertical: 10, horizontal: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              ..._getFunctions(),
                              ButtonTheme(
                                minWidth: 150.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState((){
                                      widget.controller.addField();
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      // borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(
                                      Icons.add, color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    // height: 333,
                    color: Colors.black38,
                    child: GraphInputPad(widget.storage, inputHandler.handleInput, inputHandler.handleCommand)
                  )
                ),
              ],
            ),
          ),
        )
      );
  }
}
