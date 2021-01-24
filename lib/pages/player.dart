import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mud_app/module/showToast.dart';

import '../connect.dart';

class PlayerMisc extends StatefulWidget {
  @override
  _PlayerMiscState createState() => _PlayerMiscState();
}

class _PlayerMiscState extends State<PlayerMisc> {
  StreamSubscription streamSubscription;
  @override
  void initState() {
    super.initState();
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      ShowToast.info(event.data);
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
      child: Column(
        children: [
          Center(
            child: Text("data"),
          ),
          Row(
            children: [
              Text("data:"),
            ],
          )
        ],
      ),
    );
  }
}
