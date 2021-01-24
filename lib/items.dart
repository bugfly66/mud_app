import 'global.dart';
import 'module/myshowDialog.dart';

import './function.dart';
import 'package:css_text/css_text.dart';
import 'package:flutter/material.dart';

import 'connect.dart';
import 'dart:async';

import 'sizeConfig.dart';

class Items extends StatefulWidget {
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  StreamSubscription streamSubscription;
  int itemsCount = 0;
  List itemsBtn = List();

  @override
  void initState() {
    super.initState();
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      List addItems = event.data["addItems"];
      List delItems = event.data["delIitems"];
      List createItems = event.data["createItems"];
      // if (event.data["dialog"] != null) {
      //   showDialog(
      //       context: context,
      //       barrierColor: Colors.transparent,
      //       builder: (context) {
      //         return Center(
      //           child: MyShowDialog(),
      //         );
      //       });
      // }
      //生成items
      if (createItems != null) {
        itemsCount = 0;
        itemsBtn.clear();
        createItems.forEach((value) {
          Map temp1 = Map();
          temp1["name"] = cssStyle(value["item_name"]); //name;
          temp1["type"] = value["item_type"];
          temp1["cmd"] = value["item_cmd"]; //cmd;
          itemsBtn.add(temp1);
          itemsCount++;
        });
        // print("**************************\n$itemsBtn\n");
        setState(() {});
      }
      //为房间添加items
      if (addItems != null) {
        Map temp2 = Map();
        addItems.forEach((value) {
          temp2["name"] = cssStyle(value["item_name"]); //name;
          temp2["type"] = value["item_type"];
          temp2["cmd"] = value["item_cmd"]; //cmd;
          itemsBtn.add(temp2);
          itemsCount++;
        });
        setState(() {});
      }
      // //删除items
      if (delItems != null) {
        delItems.forEach((value) {
          itemsBtn.removeWhere((element) => element['cmd'] == value["cmd"]);
          itemsCount--;
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
    return Container(
      width: Global.itemWidth,
      color: Colors.transparent, //Colors.green,
      height: Global.itemHeight * 0.7,
      alignment: Alignment.center,
      child: ListView.builder(
          itemCount: itemsCount,
          itemBuilder: (context, index) {
            return Column(children: [
              SizedBox(
                height: 2,
              ),
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/bg18.png"),
                  )),
                  alignment: Alignment.center,
                  height: SizeConfig.blockSizeVertical * 6,
                  width: Global.itemWidth - 2,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    child: Stack(
                      children: [
                        Positioned(
                            left: 2,
                            top: 1,
                            child: Text(itemsBtn[index]["type"],
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ))),
                        Positioned(
                          bottom: 0,
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            // color: Colors.blue,
                            width: SizeConfig.blockSizeVertical * 10,
                            alignment: Alignment.center,
                            child: HTML.toRichText(
                                context, itemsBtn[index]['name']),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierColor: Colors.transparent,
                          builder: (context) {
                            return Center(
                              child: MyShowDialog(cmd: itemsBtn[index]['cmd']),
                            );
                          });
                    },
                  ))
            ]);
          }),
      //*******网格型******
      // GridView.builder(
      //     itemCount: itemsCount,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 4,
      //       mainAxisSpacing: 2,
      //       crossAxisSpacing: 2,
      //       childAspectRatio: 8 / 3,
      //     ),
      //     itemBuilder: (context, index) {
      //       return Row(
      //         children: <Widget>[
      //           SizedBox(
      //             height: 1,
      //           ),
      //           Container(
      //               alignment: Alignment.center,
      //               width: realwidth / 4 - 10,
      //               child: RaisedButton(
      //                 padding: EdgeInsets.all(0),
      //                 child: itemsBtn[index]['tag'],
      //                 onPressed: () {
      //                   client.sendMsg("${itemsBtn[index]['cmd']}");
      //                 },
      //               )),
      //         ],
      //       );
      //     })
    );
  }
}
