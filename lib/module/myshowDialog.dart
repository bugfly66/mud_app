import 'dart:async';

import 'package:css_text/css_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../function.dart';

import '../connect.dart';
import '../sizeConfig.dart';

class MyShowDialog extends StatefulWidget {
  final cmd;
  MyShowDialog({Key key, @required this.cmd}) : super(key: key);
  @override
  _MyShowDialogState createState() => _MyShowDialogState();
}

class _MyShowDialogState extends State<MyShowDialog> {
  StreamSubscription streamSubscription;
  String title = "标题", miscInfo = "详细信息";
  List inquiry = List(), action = List();
  List inquiryItems = List<Map>(), actionItems = List<Map>();
  int inquiryCount = 0, actionCount = 0;
  double inqHeight = 0.0, actHeight = 0.0;
  double containerH = SizeConfig.blockSizeVertical * 50;
  double trueH = SizeConfig.blockSizeVertical * 50 - 20;
  double titleH = SizeConfig.blockSizeVertical * 5;
  @override
  void initState() {
    client.sendMsg(widget.cmd);
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      Map dialog = event.data["dialog"];
      if (dialog != null) {
        title = dialog["title"];
        miscInfo = dialog["desc"] == "" ? "无" : dialog["desc"];
        inquiry = dialog["inquiry"];
        action = dialog["actions"];
        // print("\n\n\n\n\n\n\ninquiry:$inquiry\n\n\n\n\n\n\n\n");
        if (inquiry != null) {
          inquiry.forEach((element) {
            // print("$element");
            inquiryItems.add(element);
            inquiryCount++;
          });
        }
        if (action != null) {
          action.forEach((element) {
            actionItems.add(element);
            actionCount++;
          });
        }
        inquiryCount == 0 ? inqHeight = 0.0 : inqHeight = trueH * 0.3;
        actionCount == 0 ? actHeight = 0.0 : actHeight = trueH * 0.4;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
      height: SizeConfig.blockSizeVertical * 50,
      width: SizeConfig.blockSizeHorizontal * 80,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill, image: AssetImage("assets/images/bg14.png")),
      ),
      child: Stack(
        children: [
          Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage("assets/images/back.png")),
                ),
                child: FlatButton(
                  child: null,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )),
          Positioned(
              top: 3,
              right: 25,
              left: 25,
              child: Container(
                height: titleH,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage("assets/images/bg15.png")),
                ),
                alignment: Alignment.center,
                child: RichText(
                  text: HTML.toTextSpan(context, cssStyle(title)),
                  strutStyle: StrutStyle(),
                ),
              )),
          Positioned(
              top: titleH + 3,
              right: 0,
              left: 0,
              child: Container(
                height: trueH - inqHeight - actHeight,
                alignment: Alignment.center,
                // color: Colors.amber,
                child: SingleChildScrollView(
                  child: HTML.toRichText(context, cssStyle(miscInfo)),
                ),
              )),
          Positioned(
              top: titleH + trueH + 3 - inqHeight - actHeight,
              left: 0,
              right: 0,
              child: Container(
                  height: inqHeight,
                  //  color: Colors.blue,
                  child: GridView.builder(
                    itemCount: inquiryCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 2),
                    itemBuilder: (context, index) {
                      return OutlinedButton(
                          onPressed: () {
                            client.sendMsg("${inquiryItems[index]["cmd"]}\n");
                            Navigator.of(context).pop();
                          },
                          child: HTML.toRichText(context,
                              cssStyle("${inquiryItems[index]["name"]}\n")));
                    },
                  ))),
          Positioned(
              top: titleH + trueH + 3 - actHeight,
              left: 0,
              right: 0,
              child: Container(
                  height: actHeight,
                  child: GridView.builder(
                    itemCount: actionCount,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 2),
                    itemBuilder: (context, index) {
                      return OutlinedButton(
                          onPressed: () {
                            client.sendMsg("${actionItems[index]["cmd"]}\n");
                            Navigator.of(context).pop();
                          },
                          child: HTML.toRichText(context,
                              cssStyle("${actionItems[index]["name"]}\n")));
                    },
                  ))),
        ],
      ),
    );
  }
}
