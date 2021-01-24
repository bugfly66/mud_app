import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mud_app/module/showToast.dart';
import 'package:mud_app/pages/settings.dart';

import '../connect.dart';

class ToastListenButton extends StatefulWidget {
  @override
  _ToastListenButtonState createState() => _ToastListenButtonState();
}

class _ToastListenButtonState extends State<ToastListenButton> {
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
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SettingsPage()));
          }),
    );
  }
}
