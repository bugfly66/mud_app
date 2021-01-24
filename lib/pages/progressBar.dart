import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../sizeConfig.dart';

import '../connect.dart';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  StreamSubscription streamSubscription;
  int rowNum = 1, sum = 0;
  double aspectRatio = 16;
  List<String> barName = List<String>();
  //List barContent = List();
  List eff = List();
  List max = List();
  List real = List();
  List color = List();
  @override
  void initState() {
    super.initState();
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      Map progressBar = event.data["progressBar"];
      if (progressBar != null) {
        sum = 0;
        eff.clear();
        max.clear();
        real.clear();
        color.clear();
        rowNum = progressBar["config"]["rowNum"];
        aspectRatio = progressBar["config"]["aspectRatio"] == 0.0
            ? 32.0 / rowNum
            : progressBar["config"]["aspectRatio"];
        progressBar.remove("config");
        progressBar.forEach((key, value) {
          barName.add(key);
          max.add(value["max"]);
          real.add(value["real"] / value["max"]);
          eff.add(value["eff"] / value["max"]);
          color.add(value["color"]);
          sum++;
        });
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: SizeConfig.screenWidth,
      height: SizeConfig.blockSizeVertical * 1,
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: sum,
          padding: EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: rowNum, childAspectRatio: aspectRatio),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                  border: Border.all(width: 0.5, color: Colors.brown)),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.centerLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    child: LinearProgressIndicator(
                      minHeight: 3,
                      value: eff[index],
                      backgroundColor: Colors.black54,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white70),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    child: LinearProgressIndicator(
                      value: real[index],
                      backgroundColor: Colors.transparent,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color(int.parse(color[index]))),
                    ),
                  ),
                  Container(
                    child: AutoSizeText(
                      barName[index],
                      style: TextStyle(fontSize: 30),
                      minFontSize: 1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
