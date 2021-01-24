import 'dart:async';

import 'package:css_text/css_text.dart';
import 'package:flutter/material.dart';

import 'connect.dart';
import 'sizeConfig.dart';

class Channel extends StatefulWidget {
  @override
  _ChannelState createState() => _ChannelState();
}

class _ChannelState extends State<Channel> {
  StreamSubscription streamSubscription;

  Map channels = Map();
  List allChannelMsg = List();
  @override
  void initState() {
    super.initState();
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      Map channelMsg = event.data["channel"];
      channelMsg.forEach((key, value) {
        allChannelMsg.add(HTML.toRichText(context, value));
        if (allChannelMsg.length > 50) {
          int end = allChannelMsg.length - 51;
          allChannelMsg.removeRange(0, end);
        }
      });
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
      height: SizeConfig.blockSizeVertical * 7,
      width: SizeConfig.screenWidth,
      color: Colors.transparent,
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: allChannelMsg.length,
        itemBuilder: (context, index) {
          return allChannelMsg[index];
        },
      ),
    );
  }
}
