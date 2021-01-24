import 'package:flutter/material.dart';
import '../connect.dart';
import '../page.dart';

class NewPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            "assets/images/bar1.png",
            fit: BoxFit.fitWidth,
          ),
        ],
        // title: Text("设定"),
      ),
      body: Player(),
    );
  }
}

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final name = TextEditingController();
  String gender = "";
  int groupValue = 1;
  @override
  void dispose() {
    super.dispose();
    name.dispose();
  }

  onChange(value) {
    setState(() {
      groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: '中文',
                labelText: '昵称',
              ),
            )),
        Container(
          child: Row(
            children: [
              Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) => onChange(value)),
                  Text("男")
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) => onChange(value)),
                  Text("女")
                ],
              )
            ],
          ),
        ),
        Container(
          child: RaisedButton(onPressed: () {
            if (groupValue == 1) gender = "男性";
            if (groupValue == 2) gender = "女性";
            client.sendMsg(name.text + "║" + gender);
            Navigator.pushAndRemoveUntil(
                context,
                new MaterialPageRoute(
                    builder: (context) => BottomNavigationWidget()),
                (_) => false);
          }),
        )
      ],
    );
  }
}
