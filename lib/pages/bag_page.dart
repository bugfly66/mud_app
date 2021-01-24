import 'dart:async';

import 'package:css_text/css_text.dart';
import 'package:flutter/material.dart';
import 'package:mud_app/function.dart';
import '../global.dart';
import '../sizeConfig.dart';

import '../connect.dart';

class BagPage extends StatefulWidget {
  @override
  _BagPageState createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> with AutomaticKeepAliveClientMixin {
  StreamSubscription streamSubscription;
  int _currCount = 0, _maxCount = 0;
  Map wield;
  Map wield1 = Map(),
      wield2 = Map(),
      wield3 = Map(),
      wield4 = Map(),
      wield5 = Map(),
      wield6 = Map();

  List bagItems = List();

  String boy = "assets/images/shadow_boy.png",
      girl = "assets/images/shadow_girl.png";
  String gender = "assets/images/shadow_boy.png";
  @override
  void initState() {
    client.sendMsg("inventory0");
    wield1["name"] = "武器";
    wield2["name"] = "衣服";
    wield3["name"] = "鞋子";
    wield4["name"] = "防具";
    wield5["name"] = "辅助1";
    wield6["name"] = "辅助2";
    streamSubscription = eventBus.on<DataChange>().listen((event) {
      // ShowToast.info(event.data);
      Map bag = event.data["bag"];
      Map addBagItem = event.data["addBagItem"];
      Map delBagItem = event.data["delBagItem"];
      if (bag != null) {
        _maxCount = bag["maxItemCount"];
        if (bag["gender"] == "男性") {
          gender = boy;
        } else {
          gender = girl;
        }
        wield = bag["wield"];
        if (wield.isNotEmpty) {
          wield1 = wield["arms"];
          wield2 = wield["cloth"];
          wield3 = wield["shoes"];
          wield4 = wield["armor"];
          wield5 = wield["other1"];
          wield6 = wield["other2"];
        }
        bagItems = bag["bagItems"];
        _currCount = bagItems.length;
        print("bagitems:$bagItems");
        setState(() {});
      }
      if (addBagItem != null) {
        addBagItem.forEach((key, value) {
          bagItems.add(value);
          _currCount++;
        });
        setState(() {});
      }
      if (delBagItem != null) {
        delBagItem.forEach((key, value) {
          bagItems.removeWhere((element) => false);
          _currCount--;
        });
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        width: SizeConfig.screenWidth,
        child: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: Global.equipHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/bg8.png")),
              ),
              child: Row(
                children: [
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 27,
                    height: Global.equipHeight - 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: OutlineButton(
                              padding: EdgeInsets.all(0),
                              child: HTML.toRichText(context, wield1["name"]),
                              onPressed: () {
                                client.sendMsg("${wield1['cmd']}\n");
                              }),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: OutlineButton(
                              padding: EdgeInsets.all(0),
                              child: HTML.toRichText(context, wield2["name"]),
                              onPressed: () {
                                client.sendMsg("${wield2['cmd']}\n");
                              }),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: OutlineButton(
                              padding: EdgeInsets.all(0),
                              child: HTML.toRichText(context, wield3["name"]),
                              onPressed: () {
                                client.sendMsg("${wield3['cmd']}\n");
                              }),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitHeight, image: AssetImage(gender)),
                        ),
                        height: SizeConfig.blockSizeVertical * 35 - 50,
                        width: SizeConfig.blockSizeHorizontal * 46,
                      ),
                      Container(
                          height: 50,
                          width: SizeConfig.blockSizeHorizontal * 46,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 50,
                                  width: 50,
                                  child: OutlineButton(onPressed: null),
                                );
                              }))
                    ],
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 27,
                    height: Global.equipHeight - 50,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: OutlineButton(
                              padding: EdgeInsets.all(0),
                              child: HTML.toRichText(context, wield4["name"]),
                              onPressed: () {
                                client.sendMsg("${wield4['cmd']}\n");
                              }),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: OutlineButton(
                              padding: EdgeInsets.all(0),
                              child: HTML.toRichText(context, wield5["name"]),
                              onPressed: () {
                                client.sendMsg("${wield5['cmd']}\n");
                              }),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          child: OutlineButton(
                              padding: EdgeInsets.all(0),
                              child: HTML.toRichText(context, wield6["name"]),
                              onPressed: () {
                                client.sendMsg("${wield6['cmd']}\n");
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: Global.bagHeight,
              child: Container(
                child: Text("容量：$_currCount/$_maxCount"),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  height: Global.bagHeight,
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/bg8.png")),
                  ),
                  child: GridView.builder(
                      itemCount: _currCount,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 1,
                          crossAxisCount: 6),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/bg9.png")),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/images/shadow_girl.png")),
                              ),
                              child: OutlineButton(
                                  child: HTML.toRichText(context,
                                      cssStyle(bagItems[index]["name"])),
                                  onPressed: () {
                                    client
                                        .sendMsg("${bagItems[index]['cmd']}\n");
                                  })),
                        );
                      }),
                ))
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
