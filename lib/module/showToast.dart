import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowToast {
  static void info(Map data) {
    Map toast = data["toast"];
    // print(
    //     "|+++++++++++++++++++++++++++++++++|\n$toast\n|+++++++++++++++++++++++++++++++++|");
    if (toast == null) return;
    int durationd, ard, ad;
    double x, y, borderRadiusd;
    Color fontColor, contentColord;
    bool one;
    //持续时间毫秒
    toast["duration"] == null
        ? durationd = 2000
        : durationd = toast["duration"];
    toast["animationReverseDuration"] == null
        ? ard = 2000
        : ard = toast["animationReverseDuration"];
    //动画持续时间
    toast["animationDuration"] == null
        ? ad = 1000
        : ad = toast["animationDuration"];
    toast["borderRadius"] == null
        ? borderRadiusd = 2.0
        : borderRadiusd = toast["borderRadius"];
    //位置
    if (toast["align"]["x"] != null && toast["align"]["y"] != null) {
      if (toast["align"]["x"] == "random" || toast["align"]["y"] == "random") {
        x = 2 * Random().nextDouble() - 1;
        y = 2 * Random().nextDouble() - 1;
      } else {
        x = toast["align"]["x"];
        y = toast["align"]["y"];
      }
    } else {
      x = 0;
      y = 0;
    }

    one = toast["onlyOne"] == "false" ? false : true;

    //弹出字体颜色
    if (toast["fontColor"] != null) {
      if (toast["fontColor"] == "randomColor") {
        //随机颜色
        fontColor = Color.fromARGB(
          255,
          Random.secure().nextInt(200),
          Random.secure().nextInt(200),
          Random.secure().nextInt(200),
        );
      } else {
        fontColor = Color(int.parse(toast["fontColor"]));
      }
    } else {
      //默认为白色
      fontColor = Colors.white;
    }
    //背景颜色
    if (toast["contentColor"] != null) {
      if (toast["contentColor"] == "randomColor") {
        //随机颜色
        contentColord = Color.fromARGB(
          255,
          Random.secure().nextInt(255),
          Random.secure().nextInt(255),
          Random.secure().nextInt(255),
        );
      } else {
        contentColord = Color(int.parse(toast["contentColor"]));
      }
    } else {
      //默认为灰色
      contentColord = Colors.grey[700];
    }
    BotToast.showText(
      text: toast["msg"],
      duration: Duration(milliseconds: durationd),
      contentColor: contentColord,
      onlyOne: one,
      align: Alignment(x, y),
      animationReverseDuration: Duration(milliseconds: ard),
      animationDuration: Duration(milliseconds: ad),
      borderRadius: BorderRadius.all(Radius.circular(borderRadiusd)),
      textStyle: TextStyle(fontSize: toast["fontSize"], color: fontColor),
    );
  }
}
