import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mud_app/pages/new_player.dart';
import '../connect.dart';
import '../function.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
      ),
      body: Reg(),
    );
  }
}

class Reg extends StatefulWidget {
  @override
  _RegState createState() => _RegState();
}

class _RegState extends State<Reg> {
  final id = TextEditingController();
  final pwd1 = TextEditingController();
  final pwd2 = TextEditingController();
  final email = TextEditingController();
  StreamSubscription streamSubscription;
  // String _toast = "";
  @override
  void initState() {
    super.initState();
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      String reg = event.data["reg"];
      if (reg == "regsuccess") {
        Navigator.pushAndRemoveUntil(
            context,
            new MaterialPageRoute(builder: (context) => NewPlayer()),
            (route) => route == null);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    id.dispose();
    pwd1.dispose();
    pwd2.dispose();
    email.dispose();
    streamSubscription.cancel();
  }

  bool alert() {
    if (pwd1.text != pwd2.text) {
      BotToast.showText(text: "两次输入的密码不一");
      return false;
    }
    if (id.text.length > 6 || id.text.length < 3) {
      BotToast.showText(text: "id长度不符合要求");
      return false;
    }
    if (id.text.replaceAll(RegExp(r"^[A-Za-z]+$"), "") != "") {
      BotToast.showText(text: "id必须全为英文");
      return false;
    }
    if (!RegExp(
            r"^[0-9A-Za-z][\.-_0-9A-Za-z]*@[0-9A-Za-z]+(?:\.[0-9A-Za-z]+)+$")
        .hasMatch(email.text)) {
      BotToast.showText(text: "邮箱格式错误！");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            child: TextField(
              controller: id,
              decoration: InputDecoration(
                hintText: '3-6位英文字母',
                labelText: 'ID',
              ),
            )),
        Container(
            width: double.infinity,
            child: TextField(
              controller: pwd1,
              decoration: InputDecoration(
                hintText: '输入密码',
                labelText: '密码',
              ),
            )),
        Container(
            width: double.infinity,
            child: TextField(
              controller: pwd2,
              decoration: InputDecoration(
                hintText: '确认密码',
                labelText: '重复密码',
              ),
            )),
        Container(
            width: double.infinity,
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: '请如实填写，遗忘密码将通过邮箱找回',
                labelText: '邮箱',
              ),
            )),
        Container(
          child: RaisedButton(
              child: Text("注册"),
              onPressed: () {
                if (alert()) {
                  client.sendMsg("reg");

                  client.sendMsg(id.text +
                      "║" +
                      pwd1.text +
                      "║" +
                      email.text +
                      "║" +
                      check);
                  Storage.setdata("userId", id.text);
                  Storage.setdata("userpwd", pwd1.text);
                }
              }),
        )
      ],
    );
  }
}
