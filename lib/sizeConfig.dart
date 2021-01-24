import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;

  static double screenWidth;

  static double screenHeight;

  static double blockSizeHorizontal;

  static double blockSizeVertical;

// 初始化方法

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

// flutter系统提供的类，可以查询屏幕方向，屏幕宽、高

// 返回的宽、高，单位： dp, 宽高返回的单位是 dp 哦！！！

// 返回屏幕宽高，是随着屏幕旋转，返回值是不一样的 ！！！

    screenWidth = _mediaQueryData.size.width;

    screenHeight = _mediaQueryData.size.height -
        _mediaQueryData.padding.top -
        _mediaQueryData.padding.bottom;
    print(
        "full:${_mediaQueryData.size.height}\ntruth:${_mediaQueryData.padding.top}");
// 屏幕宽高 ，均分 100 份

    blockSizeHorizontal = screenWidth / 100;

    blockSizeVertical = screenHeight / 100;
  }
}
