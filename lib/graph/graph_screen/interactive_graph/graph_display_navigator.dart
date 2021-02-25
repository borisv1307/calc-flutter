import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';

class GraphDisplayNavigator extends StatefulWidget {
  final ScaleSettings scaleSettings;

  GraphDisplayNavigator(this.scaleSettings);

  @override
  State<StatefulWidget> createState() => GraphDisplayNavigatorState();
}

class GraphDisplayNavigatorState extends State<GraphDisplayNavigator> {
  void _updateScale() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.scaleSettings.addListener(_updateScale);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:Opacity(
          opacity: 0.3,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          this.widget.scaleSettings.yMax++;
                          this.widget.scaleSettings.yMin++;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 36,
                      )),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              this.widget.scaleSettings.xMax--;
                              this.widget.scaleSettings.xMin--;
                            });
                          },
                          child: Icon(
                            Icons.chevron_left,
                            size: 36,
                          )),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              this.widget.scaleSettings.xMax++;
                              this.widget.scaleSettings.xMin++;
                            });
                          },
                          child: Icon(
                            Icons.chevron_right,
                            size: 36,
                          )),
                    ),
                  ],
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          this.widget.scaleSettings.yMax--;
                          this.widget.scaleSettings.yMin--;
                        });
                      },
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        size: 36,
                      )),
                ),
              ],
            ),
          ),
        )
    );
  }
}
