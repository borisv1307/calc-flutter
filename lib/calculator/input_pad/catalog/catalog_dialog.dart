import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:open_calc/calculator/input_pad/input_item.dart';

class CatalogDialog extends StatefulWidget{
  final List<InputItem> catalogItems = const [
    InputItem.ADD,
    InputItem.SUBTRACT,
    InputItem.MULTIPLY,
    InputItem.DIVIDE,
    InputItem.DECIMAL,
    InputItem.COMMA,
    InputItem.POWER,
    InputItem.OPEN_PARENTHESIS,
    InputItem.CLOSE_PARENTHESIS,
    InputItem.NEGATIVE,
    InputItem.ACOS,
    InputItem.ACOSH,
    InputItem.ANSWER,
    InputItem.ASIN,
    InputItem.ASINH,
    InputItem.ATAN,
    InputItem.ATANH,
    InputItem.COS,
    InputItem.COSH,
    InputItem.COT,
    InputItem.CSC,
    InputItem.E_POWER_X,
    InputItem.NATURAL_LOG,
    InputItem.LOG,
    InputItem.SEC,
    InputItem.SIN,
    InputItem.SINH,
    InputItem.TAN,
    InputItem.TANH,
    InputItem.INVERSE,
    InputItem.SQUARED,
  ];

  final Function(InputItem input) onTap;

  CatalogDialog(this.onTap);

  @override
  State<StatefulWidget> createState() => CatalogDialogState();

}

class CatalogDialogState extends State<CatalogDialog>{
  TextEditingController controller = TextEditingController();

  List<InputItem> filterCatalogItems(String text) {
    List<InputItem> items = this.widget.catalogItems;
    if(text.isNotEmpty){
      items = this.widget.catalogItems.where((item) => item.display.toUpperCase().contains(text) ||
          item.value.toUpperCase().contains(text) ||
          item.name.toUpperCase().contains(text)).toList();
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    List<InputItem> displayItems = filterCatalogItems(controller.text.toUpperCase());
    return SimpleDialog(
      title: TextField(
        onChanged: (text){
          setState(() {
          });
        },
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Enter input name...'
        ),
      ),
      children: [
        if(displayItems.isNotEmpty)
          Container(
            child: Tags(
              itemCount: displayItems.length,
              itemBuilder: (int index){
                InputItem item = displayItems[index];
                return ItemTags(
                  index: index,
                  title: item.display,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  onPressed: (Item item){
                    Navigator.pop(context);
                    this.widget.onTap(displayItems[item.index]);
                  },
                );
              },
            )
          ),
        if(displayItems.isEmpty)
          Center(child:Text('No matches found'))
      ]
    );
  }
}