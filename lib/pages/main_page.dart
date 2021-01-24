import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:css_text/css_text.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import '../connect.dart';
import '../global.dart';
import '../items.dart';
import '../map.dart';
import '../pages/miscMsg.dart';
import '../pages/player.dart';
import '../pages/progressBar.dart';
import '../pages/roomDesc.dart';
import '../sizeConfig.dart';

class PainterDemo extends StatefulWidget {
  @override
  _PainterDemoState createState() => _PainterDemoState();
}

class _PainterDemoState extends State<PainterDemo>
    with AutomaticKeepAliveClientMixin {
  String _state = "exits";
  @override
  void initState() {
    super.initState();
    client.sendMsg("inventory0");
  }

  @override
  bool get wantKeepAlive => true;
  Widget other1 = Container(
    height: Global.exitsHeight,
    child: GridView.builder(
        itemCount: 10,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 2, crossAxisCount: 5, childAspectRatio: 1.3),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
            height: Global.playerMsgHeight / 4,
            // width: ,
            child: RaisedButton(child: Text("data"), onPressed: () {}),
          );
        }),
  );
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.topCenter,
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        //color: Colors.blue,
        child: Wrap(
          children: [
            Row(children: [
              Container(
                  //items
                  color: Colors.transparent,
                  height: Global.itemHeight,
                  width: Global.itemWidth,
                  child: Column(
                    children: [
                      Container(
                        //padding: EdgeInsets.all(5),
                        height: Global.itemHeight * 0.3,
                        width: Global.itemWidth,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/bg7.png")),
                        ),
                        child: PlayerMisc(),
                      ),
                      Items(),
                    ],
                  )),
              Container(
                color: Colors.transparent,
                height: SizeConfig.blockSizeVertical * 57,
                width: SizeConfig.screenWidth - Global.itemWidth,
                child: Stack(
                  children: [
                    Positioned(
                      top: SizeConfig.blockSizeVertical * 9,
                      child: Container(
                        //msg
                        color: Colors.transparent,
                        height: Global.msgHeight,
                        width: SizeConfig.screenWidth - Global.itemWidth,
                        child: MiscMsg(),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        //height: Global.roomHeight,
                        width: SizeConfig.screenWidth - Global.itemWidth,
                        child: Room()),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          //血条，战斗时出现吧，和上面的同时显示，记住⭐
                          color: Colors.transparent, // Color(0x11aaffff),
                          height: SizeConfig.blockSizeVertical * 5,
                          width: SizeConfig.screenWidth -
                              SizeConfig.blockSizeVertical * 10,
                          child: ProgressBar(),
                        ))
                  ],
                ),
              ),
            ]),
            Row(
              children: [
                Container(
                  color: Color(0x66aaffff),
                  width: Global.playerMsgWidth,
                  height: Global.playerMsgHeight,
                  child: PlayerMisc(),
                ), //
                Container(
                    //地图
                    color: Colors.transparent,
                    width: SizeConfig.screenWidth - Global.itemWidth,
                    height: Global.exitsHeight,
                    child: Stack(
                      children: [
                        Positioned.fill(
                            child: Visibility(
                                maintainState: true,
                                visible: _state == "exits" ? true : false,
                                child: Exits())),
                        Positioned.fill(
                            child: Visibility(
                                visible: _state == "other1" ? true : false,
                                child: other1))
                      ],
                    ))
              ],
            ),
            Row(
              children: [
                Container(
                    height: Global.otherHeight,
                    alignment: Alignment.center,
                    child: Container(
                      height: Global.otherHeight / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage("assets/images/bg_jjc7.png")),
                      ),
                      child: FlatButton(
                        child: Text("地图"),
                        onPressed: () {
                          client.sendMsg("look");
                          if (_state != "exits") {
                            setState(() {
                              _state = "exits";
                            });
                          }
                        },
                      ),
                    )),
                Container(
                    height: Global.otherHeight,
                    alignment: Alignment.center,
                    child: Container(
                      height: Global.otherHeight / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage("assets/images/bg_jjc7.png")),
                      ),
                      child: FlatButton(
                        child: Text("其他"),
                        onPressed: () {
                          if (_state != "other1") {
                            setState(() {
                              _state = "other1";
                            });
                          }
                        },
                      ),
                    )),
                Container(
                    height: Global.otherHeight,
                    alignment: Alignment.center,
                    child: Container(
                      height: Global.otherHeight / 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage("assets/images/bg_jjc7.png")),
                      ),
                      child: FlatButton(
                        child: HTML.toRichText(context,
                            "<span style = \"background:rgb(255,255,0)\"><span style = \"color:red\">广告</span></span>"),
                        onPressed: () {
                          RewardedVideoAd.instance.listener =
                              (RewardedVideoAdEvent event,
                                  {String rewardType, int rewardAmount}) {
                            switch (event) {
                              case RewardedVideoAdEvent.loaded:
                                RewardedVideoAd.instance.show();
                                BotToast.showText(text: "加载广告成功！");
                                break;
                              case RewardedVideoAdEvent.failedToLoad:
                                //读取失败！
                                BotToast.showText(text: "加载广告失败！");
                                break;
                              case RewardedVideoAdEvent.opened:
                                break;
                              case RewardedVideoAdEvent.leftApplication:
                                break;
                              case RewardedVideoAdEvent.closed:
                                break;
                              case RewardedVideoAdEvent.rewarded:
                                print("*********奖励 $rewardAmount");
                                client.sendMsg("rewarded 1 \n");
                                print("时间戳：" +
                                    DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString());
                                break;
                              case RewardedVideoAdEvent.started:
                                break;
                              case RewardedVideoAdEvent.completed:
                                print("播放完毕");

                                break;
                            }
                          };
                          MobileAdTargetingInfo targetingInfo =
                              MobileAdTargetingInfo(
                                  keywords: <String>[
                                'leisure',
                                'game',
                                'relaxation',
                                'puzzle'
                              ],
                                  contentUrl: 'https://flutter.io',
                                  childDirected: false,
                                  // testDevices: [
                                  //   "26DB97270BB77B722D04F2B999569ECF"
                                  // ],
                                  // Android emulators are considered test devices
                                  nonPersonalizedAds: true);
                          RewardedVideoAd.instance.load(
                              adUnitId:
                                  "ca-app-pub-6454060774191147/6748450998", //"ca-app-pub-3940256099942544/5224354917",
                              targetingInfo: targetingInfo);
                        },
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class CanvasPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.black // 画笔的颜色
//       ..strokeWidth = 2.0; // 线的宽度
//     var a = SizeConfig.blockSizeVertical * 10;
//     canvas.drawLine(
//         Offset(0, a * 0.8), Offset(SizeConfig.screenWidth, a * 0.8), paint);
//     canvas.drawLine(Offset(a, 0), Offset(a, SizeConfig.screenHeight), paint);
//     canvas.drawLine(Offset(a * 2, a * 6.5), Offset(a * 2, a * 8), paint);
//     canvas.drawLine(
//         Offset(a, a * 2.8), Offset(SizeConfig.screenWidth, a * 2.8), paint);
//     canvas.drawLine(
//         Offset(a, a * 3.3), Offset(SizeConfig.screenWidth, a * 3.3), paint);
//     canvas.drawLine(
//         Offset(a, a * 6), Offset(SizeConfig.screenWidth, a * 6), paint);

//     canvas.drawLine(
//         Offset(0, a * 6.5), Offset(SizeConfig.screenWidth, a * 6.5), paint);

//     canvas.drawLine(
//         Offset(0, a * 8), Offset(SizeConfig.screenWidth, a * 8), paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
