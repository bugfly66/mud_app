import 'dart:async';

import '../function.dart';
import '../module/showToast.dart';
import '../page.dart';

import '../connect.dart';
import 'package:flutter/material.dart';
import './register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      String tip;
      ShowToast.info(event.data);
      if (event.data["login"] != null) {
        tip = event.data["login"];
      }

      if (tip == "loginsuccess") {
        Storage.setdata("userId", myController1.text);
        Storage.setdata("userpwd", myController2.text);
        Navigator.pushAndRemoveUntil(
            context,
            new MaterialPageRoute(
                builder: (context) => BottomNavigationWidget()),
            (route) => route == null);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    myController1.dispose();
    myController2.dispose();
    streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Storage.getdata("userId").then((value) {
      myController1.text = value;
    });
    Storage.getdata("userpwd").then((value) {
      myController2.text = value;
    });
    return Column(
      children: <Widget>[
        Container(
          height: 80,
          width: 80,
          margin: EdgeInsets.only(top: 50),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Logo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            '登录',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 30,
          ),
          child: TextField(
            controller: myController1,
            decoration: InputDecoration(
              hintText: '英文字母',
              labelText: 'ID',
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 30,
          ),
          child: TextField(
            controller: myController2,
            obscureText: true,
            decoration: InputDecoration(
              hintText: '请输入你的密码',
              labelText: '密码',
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 30,
          ),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '登录',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.redAccent,
            onPressed: () async {
              //Map jsonMap = json.decode(temp);

              client.sendMsg("login").then((value) {
                client.sendMsg(myController1.text +
                    "║" +
                    myController2.text +
                    "║" +
                    check);
              });
              // Navigator.pushAndRemoveUntil(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (context) => BottomNavigationWidget()),
              //     (route) => route == null);
              // print(Storage.getdata("userId"));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 30,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: OutlineButton(child: Text("忘记密码"), onPressed: () {}),
              ),
              Expanded(
                flex: 1,
                child: OutlineButton(
                    child: Text("注册账号"),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Register()),
                          (_) => false);
                    }),
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
        Container(
          margin: EdgeInsets.only(
            left: 30,
            right: 30,
          ),
        ),
      ],
    );
  }
}
