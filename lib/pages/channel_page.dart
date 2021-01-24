import 'dart:async';

import 'package:css_text/css_text.dart';
import 'package:flutter/material.dart';
import '../sizeConfig.dart';

import '../connect.dart';

class ChannelPage extends StatefulWidget {
  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription streamSubscription;
  Map channels = Map();
  List allChannelMsg = List();
  List chat = List();
  List rumor = List();
  List sys = List();
  List wiz = List();
  List family = List();
  List other = List();
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      Map channelMsg = event.data["channel"];
      if (channelMsg != null) {
        channelMsg.forEach((key, value) {
          allChannelMsg.add(HTML.toRichText(context, value));
          if (key == "chat") {
            chat.add(HTML.toRichText(context, value));
          } else if (key == "rumor") {
            rumor.add(HTML.toRichText(context, value));
          } else if (key == "sys") {
            sys.add(HTML.toRichText(context, value));
          } else if (key == "family") {
            family.add(HTML.toRichText(context, value));
          } else if (key == "wiz") {
            wiz.add(HTML.toRichText(context, value));
          } else {
            other.add(HTML.toRichText(context, value));
          }
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
    super.build(context);
    return SingleChildScrollView(
      child: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: Colors.blue,
        child: null,
      ),
    );
  }
}
