import 'package:flutter/material.dart';

import 'dart:async';

import '../connect.dart';

class EmailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.black87, child: Chat()));
  }
}

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String str = "";
  int i = 0;
  String msg = "";
  Widget channelMsg;
  StreamSubscription streamSubscription;
  final myController = TextEditingController();
  FocusNode _fous = FocusNode();
  List channelmsg = List();
  @override
  void initState() {
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      //  ShowToast.info(event.data);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        top: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            reverse: true,
            padding: EdgeInsets.zero,
            itemCount: channelmsg.length,
            itemBuilder: (context, i) {
              return channelmsg[i];
            },
          ),
        ),
      ),
      Positioned(
          bottom: 0,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  alignment: Alignment.bottomLeft,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    maxLines: null,
                    focusNode: _fous,
                    controller: myController,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    child: Text(
                      '发送',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      client.sendMsg("chat " + myController.text);
                      myController.text = "";
                      //FocusScope.of(context).requestFocus(FocusNode());
                      _fous.unfocus();
                    },
                  ),
                ),
              ],
            ),
          ))
    ]);
  }
}
