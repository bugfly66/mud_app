import 'dart:async';

import 'package:css_text/css_text.dart';
import 'package:flutter/material.dart';
import '../module/myBehavior.dart';

import '../connect.dart';

class MiscMsg extends StatefulWidget {
  @override
  _MiscMsgState createState() => _MiscMsgState();
}

class _MiscMsgState extends State<MiscMsg> {
  StreamSubscription streamSubscription;
  List miscMsg = List();
  @override
  void initState() {
    super.initState();
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      String data = event.data["msg"];
      if (data != null) {
        setState(() {
          miscMsg.insert(0, data);
        });
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
        child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: Scrollbar(
              thickness: 1.0,
              radius: Radius.circular(5),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                reverse: true,
                shrinkWrap: true,
                itemCount: miscMsg.length,
                itemBuilder: (context, index) {
                  return HTML.toRichText(
                      context,
                      "<span style=\"color:white\">" +
                          miscMsg[index] +
                          "</span>");
                },
              ),
            )));
  }
}
