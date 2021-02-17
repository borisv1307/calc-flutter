import 'package:flutter/material.dart';
import 'package:open_calc/graph/graph_screen/graph_details/scale_settings/scale_settings.dart';

class GraphDisplayZoom extends StatefulWidget {
  final ScaleSettings scaleSettings;

  GraphDisplayZoom(this.scaleSettings);

  @override
  State<StatefulWidget> createState() => GraphDisplayZoomState();
}

class GraphDisplayZoomState extends State<GraphDisplayZoom> {
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
    return Opacity(
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
            SizedBox(
              height: 110,
              child: Row(
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
    );
  }
}
