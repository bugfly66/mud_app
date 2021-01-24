import 'package:css_text/css_text.dart';
import 'package:flutter/material.dart';
import '../sizeConfig.dart';

class AllMsg extends StatelessWidget {
  final msg;

  const AllMsg({Key key, this.msg}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("历史信息"),
        actions: [
          IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () {
                Navigator.of(context).popUntil(ModalRoute.withName("/AllMsg"));
              })
        ],
      ),
      body: Allmsg(
        msg: msg,
      ),
    );
  }
}

class Allmsg extends StatefulWidget {
  final msg;

  const Allmsg({Key key, this.msg}) : super(key: key);
  @override
  _AllmsgState createState() => _AllmsgState();
}

class _AllmsgState extends State<Allmsg> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(0.0),
        child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          // itemExtent: 20,

          itemCount: widget.msg.length,
          itemBuilder: (context, index) {
            return HTML.toRichText(context, widget.msg[index]);
          },
        ));
  }
}
