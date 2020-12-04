import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_calc/calculator/input_pad/input_variables.dart';
import 'package:open_calc/graph/function_screen/function_text_field.dart';
import 'package:open_calc/graph/function_screen/function_display_controller.dart';
import 'package:open_calc/graph/function_screen/input_handler/graph_command_handler.dart';
import 'package:open_calc/graph/function_screen/input_handler/graph_input_handler.dart';
import 'package:open_calc/graph/graph_screen/graph_screen.dart';
import 'package:open_calc/graph/function_screen/input_pad/graph_input_pad.dart';

class FunctionScreen extends StatefulWidget {
  final VariableStorage storage;

  FunctionScreen(this.storage);
  @override
  State<StatefulWidget> createState() => FunctionScreenState(storage);

}

class FunctionScreenState extends State<FunctionScreen> {
  final _formKey = GlobalKey<FormState>();
  final VariableStorage storage;
  static List<String> functionList = [null];
  FunctionDisplayController controller;
  TextEditingController _functionController;
  InputHandler inputHandler;
  CommandHandler commandHandler;

  FunctionScreenState(this.storage) {
    controller = FunctionDisplayController();
    inputHandler = InputHandler(controller);
    commandHandler = CommandHandler(controller, storage);
  }

  @override
  void initState() {
    super.initState();
    _functionController = new TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _functionController.dispose();
    super.dispose();
  }

  List<Widget> _getFunctions(){
    List<Widget> functionsTextFields = [];
    for (int i = 0; i < functionList.length; i++) {
      functionsTextFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(child: FunctionTextField(i, controller)),
                SizedBox(width: 16,),
                // we need a dd button at last friends row only
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
        controller.removeField(index);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
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
                              controller.addField();
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
                      if(_formKey.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GraphScreen()),
                        );
                      }
                    },
                    child: Text("Generate Graph")
                ),
                Expanded(child: GraphInputPad(storage, inputHandler.handle, commandHandler.handle))
              ],
            ),
          ),
        )
    );
  }
}
