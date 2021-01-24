import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:css_text/css_text.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import '../module/myBehavior.dart';
import '../connect.dart';
import '../function.dart';
import '../sizeConfig.dart';

class Room extends StatefulWidget {
  @override
  _RoomState createState() => _RoomState();
}

class _RoomState extends State<Room> {
  final cmd = TextEditingController();
  StreamSubscription streamSubscription;
  double h = SizeConfig.blockSizeVertical * 16;
  FocusNode _fous = FocusNode();
  String roomTitle = "房间名称";
  String roomDesc = """
  房间描述
  """;
  @override
  void initState() {
    super.initState();
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      Map data = event.data["room"];
      if (data != null) {
        if (data.containsKey("room_title")) {
          setState(() {
            roomTitle = data["room_title"];
            roomDesc = data["room_desc"];
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _fous.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 9 + h,
      child: Stack(
        children: [
          Container(
            height: h + SizeConfig.blockSizeVertical * 4,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       fit: BoxFit.fill, image: AssetImage("assets/images/bg5.png")),
            // ),
            color: Colors.black87,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage("assets/images/roomTitle.png")),
                  ),
                  height: SizeConfig.blockSizeVertical * 4,
                  alignment: Alignment.center,
                  child: HTML.toRichText(context, cssStyle(roomTitle, 1.3)),
                ),
                Container(
                  height: h,
                  width: SizeConfig.screenWidth - Global.itemWidth,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      height: SizeConfig.blockSizeVertical * 16,
                      color: Colors.transparent,
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //       fit: BoxFit.fitWidth,
                      //       image: AssetImage("assets/images/bg4.png")),
                      // ),
                      child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: SingleChildScrollView(
                            child: HTML.toRichText(context, cssStyle(roomDesc)),
                          ))),
                ),
              ],
            ),
          ),
          Positioned(
              right: 0,
              height: SizeConfig.blockSizeVertical * 4,
              width: SizeConfig.blockSizeVertical * 4,
              top: 0,
              child: Container(
                alignment: Alignment.center,
                width: SizeConfig.blockSizeVertical * 4,
                height: SizeConfig.blockSizeVertical * 4,
                child: OutlineButton(
                    color: Colors.white,
                    padding: EdgeInsets.all(0),
                    child: h == 0
                        ? AutoSizeText(
                            "显示",
                            style: TextStyle(color: Colors.white),
                          )
                        : AutoSizeText(
                            "隐藏",
                            style: TextStyle(color: Colors.white),
                          ),
                    onPressed: () {
                      setState(() {
                        if (h == 0) {
                          h = SizeConfig.blockSizeVertical * 16;
                        } else
                          h = 0;
                      });
                    }),
              )),
          Positioned(
              top: h + SizeConfig.blockSizeVertical * 4,
              height: SizeConfig.blockSizeVertical * 5,
              width: SizeConfig.screenWidth - Global.itemWidth,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/bg17.png")),
                ),
              ))
        ],
      ),
    );
  }
}
