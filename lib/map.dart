import 'dart:async';
import 'dart:core';
import 'package:css_text/css_text.dart';
import './connect.dart';
import 'package:flutter/material.dart';
import './sizeConfig.dart';

class Exits extends StatefulWidget {
  @override
  _ExitsState createState() => _ExitsState();
}

class _ExitsState extends State<Exits> {
  StreamSubscription streamSubscription;
  int i = 1;
  int otherExits = 0;
  String southTag = ".";
  String northTag = ".";
  String eastTag = ".";
  String westTag = ".";
  String swTag = ".";
  String seTag = ".";
  String nwTag = ".";
  String neTag = ".";
  bool southBtn = true;
  bool northBtn = true;
  bool eastBtn = true;
  bool westBtn = true;
  bool swBtn = true;
  bool seBtn = true;
  bool neBtn = true;
  bool nwBtn = true;
  List otherExitsTag = List();
  List otherExitsDir = List();
  @override
  void initState() {
    super.initState();
    client.sendMsg("look");
    streamSubscription = eventBus.on<DataChange>().listen((event) {
//     //生成地图

      Map exitus = event.data["map"];

      if (exitus != null) {
        //---------------**位置待定**--------------------
        southBtn = true;
        northBtn = true;
        eastBtn = true;
        westBtn = true;
        swBtn = true;
        seBtn = true;
        neBtn = true;
        nwBtn = true;
        otherExits = 0;
        otherExitsDir = List();
        otherExitsTag = List();
        //---------------------------------------------
        if (exitus.containsKey("south")) {
          southTag = exitus["south"];
          southBtn = false;
          exitus.remove("south");
        }
        if (exitus.containsKey("west")) {
          westTag = exitus["west"];
          westBtn = false;
          exitus.remove("west");
        }
        if (exitus.containsKey("north")) {
          northTag = exitus["north"];
          northBtn = false;
          exitus.remove("north");
        }
        if (exitus.containsKey("east")) {
          eastTag = exitus["east"];
          eastBtn = false;
          exitus.remove("east");
        }
        if (exitus.containsKey("southwest")) {
          swTag = exitus["southwest"];
          swBtn = false;
          exitus.remove("southwest");
        }
        if (exitus.containsKey("southeast")) {
          seTag = exitus["southeast"];
          seBtn = false;
          exitus.remove("southeast");
        }
        if (exitus.containsKey("northeast")) {
          neTag = exitus["northeast"];
          neBtn = false;
          exitus.remove("northeast");
        }
        if (exitus.containsKey("northwest")) {
          nwTag = exitus["northwest"];
          nwBtn = false;
          exitus.remove("northwest");
        }
        exitus.forEach((key, value) {
          otherExitsTag.add(value);
          otherExitsDir.add(key);
          otherExits++;
        });
        setState(() {});
      }
      // //生成地图后继续添加出口
      Map addExits = event.data["add_exits"];
      if (addExits != null) {
        if (addExits.containsKey("south")) {
          southTag = addExits["south"];
          southBtn = false;
          addExits.remove("south");
        }
        if (addExits.containsKey("north")) {
          northTag = addExits["north"];
          northBtn = false;
          addExits.remove("north");
        }
        if (addExits.containsKey("west")) {
          northTag = addExits["west"];
          northBtn = false;
          addExits.remove("west");
        }
        if (addExits.containsKey("east")) {
          eastTag = addExits["east"];
          eastBtn = false;
          addExits.remove("east");
        }
        if (addExits.containsKey("southwest")) {
          swTag = addExits["southwest"];
          swBtn = false;
          addExits.remove("southwest");
        }
        if (addExits.containsKey("southeast")) {
          seTag = addExits["southeast"];
          seBtn = false;
          addExits.remove("southeast");
        }
        if (addExits.containsKey("northeast")) {
          neTag = addExits["northeast"];
          neBtn = false;
          addExits.remove("northeast");
        }
        if (addExits.containsKey("northwest")) {
          nwTag = addExits["northwest"];
          nwBtn = false;
          addExits.remove("northwest");
        }
        addExits.forEach((key, value) {
          otherExitsTag.add(value);
          otherExitsDir.add(key);
          otherExits++;
        });
        setState(() {});
      }
      // 生成地图后继续删除地图某一出口
      Map delExits = event.data["delete_exits"];
      if (delExits != null) {
        if (delExits.containsKey("south")) {
          southBtn = true;
          delExits.remove("south");
        }
        if (delExits.containsKey("west")) {
          westBtn = true;
          delExits.remove("west");
        }
        if (delExits.containsKey("north")) {
          northBtn = true;
          delExits.remove("north");
        }
        if (delExits.containsKey("east")) {
          eastBtn = true;
          delExits.remove("east");
        }
        if (delExits.containsKey("southwest")) {
          swBtn = true;
          delExits.remove("southwest");
        }
        if (delExits.containsKey("southeast")) {
          seBtn = true;
          delExits.remove("southeast");
        }
        if (delExits.containsKey("northeast")) {
          neBtn = true;
          delExits.remove("northeast");
        }
        if (delExits.containsKey("northwest")) {
          nwBtn = true;
          delExits.remove("northwest");
        }
        delExits.forEach((key, value) {
          otherExitsTag.remove(value);
          otherExitsDir.remove(key);
          otherExits--;
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
    final realWidth = SizeConfig.screenWidth;

    double mapWidth = 200; //SizeConfig.blockSizeHorizontal * 60;
    double mapHeight = 100.0; //SizeConfig.blockSizeVertical * 15;

    final buttonWidth = (mapWidth - 10) / 3;
    final buttonHeight = (mapHeight - 10) / 3;
    return Container(
        alignment: Alignment.center,
        width: SizeConfig.blockSizeHorizontal * 80,
        height: mapHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/bg19.png"),
        )),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.amber, //Colors.transparent, //
                height: mapHeight, //length * 1.5,
                width: (realWidth / 5), //length,
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: otherExits,
                  itemBuilder: (context, index) {
                    return Column(children: <Widget>[
                      Container(
                          width: (realWidth / 4) - 8,
                          height: buttonHeight,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: ResizeImage(
                                      AssetImage("assets/Exitsbtn.png"),
                                      width: buttonWidth.toInt(),
                                      height: buttonHeight.toInt()))),
                          child: RaisedButton(
                              padding: EdgeInsets.all(0),
                              color: Colors.transparent,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: HTML.toRichText(
                                    context, otherExitsTag[index]),
                              ),
                              onPressed: () {
                                client.sendMsg("${otherExitsDir[index]}");
                              }))
                    ]);
                  },
                ),
              ),
              Container(
                width: mapWidth,
                height: mapHeight,
                color: Colors.blue,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Offstage(
                        offstage: nwBtn,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: ResizeImage(
                                        AssetImage("assets/Exitsbtn.png"),
                                        width: buttonWidth.toInt(),
                                        height: buttonHeight.toInt()))),
                            padding: EdgeInsets.all(0),
                            height: buttonHeight,
                            width: buttonWidth,
                            child: RaisedButton(
                                color: Colors.transparent,
                                child: HTML.toRichText(context, nwTag),
                                onPressed: () {
                                  client.sendMsg("nw");
                                })),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Offstage(
                        offstage: neBtn,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: ResizeImage(
                                        AssetImage("assets/Exitsbtn.png"),
                                        width: buttonWidth.toInt(),
                                        height: buttonHeight.toInt()))),
                            width: buttonWidth,
                            height: buttonHeight,
                            child: RaisedButton(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(0),
                                child: HTML.toRichText(context, neTag),
                                onPressed: () {
                                  client.sendMsg("ne");
                                })),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Offstage(
                        offstage: northBtn,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: ResizeImage(
                                        AssetImage("assets/Exitsbtn.png"),
                                        width: buttonWidth.toInt(),
                                        height: buttonHeight.toInt()))),
                            width: buttonWidth,
                            height: buttonHeight,
                            child: RaisedButton(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(0),
                                child: HTML.toRichText(context, northTag),
                                onPressed: () {
                                  client.sendMsg("n");
                                })),
                      ),
                    ),
                    Positioned(
                      child: Offstage(
                        offstage: false,
                        child: Container(
                            width: buttonWidth,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: ResizeImage(
                                        AssetImage("assets/Exitsbtn.png"),
                                        width: buttonWidth.toInt(),
                                        height: buttonHeight.toInt()))),
                            child: RaisedButton(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(0),
                                child: Text("观察四周",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                                onPressed: () {
                                  client.sendMsg("look");
                                })),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Offstage(
                        offstage: eastBtn,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: ResizeImage(
                                        AssetImage("assets/Exitsbtn.png"),
                                        width: buttonWidth.toInt(),
                                        height: buttonHeight.toInt()))),
                            width: buttonWidth,
                            height: buttonHeight,
                            child: RaisedButton(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(0),
                                child: HTML.toRichText(context, eastTag),
                                onPressed: () {
                                  client.sendMsg("e");
                                })),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Offstage(
                        offstage: southBtn,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: ResizeImage(
                                        AssetImage("assets/Exitsbtn.png"),
                                        width: buttonWidth.toInt(),
                                        height: buttonHeight.toInt()))),
                            width: buttonWidth,
                            height: buttonHeight,
                            child: RaisedButton(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(0),
                                child: HTML.toRichText(context, southTag),
                                onPressed: () {
                                  client.sendMsg("s");
                                })),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Offstage(
                        offstage: swBtn,
                        child: Container(
                            width: buttonWidth,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: ResizeImage(
                                        AssetImage("assets/Exitsbtn.png"),
                                        width: buttonWidth.toInt(),
                                        height: buttonHeight.toInt()))),
                            child: RaisedButton(
                                color: Colors.transparent,
                                child: HTML.toRichText(context, swTag),
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  client.sendMsg("sw");
                                })),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Offstage(
                        offstage: seBtn,
                        child: Container(
                            width: buttonWidth,
                            height: buttonHeight,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: ResizeImage(
                                        AssetImage("assets/Exitsbtn.png"),
                                        width: buttonWidth.toInt(),
                                        height: buttonHeight.toInt()))),
                            child: RaisedButton(
                                color: Colors.transparent,
                                padding: EdgeInsets.all(0),
                                child: HTML.toRichText(context, seTag),
                                onPressed: () {
                                  client.sendMsg("se");
                                })),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        child: Offstage(
                          offstage: westBtn,
                          child: Container(
                              width: buttonWidth,
                              height: buttonHeight,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: ResizeImage(
                                          AssetImage("assets/Exitsbtn.png"),
                                          width: buttonWidth.toInt(),
                                          height: buttonHeight.toInt()))),
                              child: RaisedButton(
                                  color: Colors.transparent,
                                  padding: EdgeInsets.all(0),
                                  child: HTML.toRichText(context, westTag),
                                  onPressed: () {
                                    client.sendMsg("w");
                                  })),
                        )),
                  ],
                ),
              )
            ]));
  }
}
