import 'package:flutter/widgets.dart';
import './sizeConfig.dart';

class Global {
  static void init(BuildContext context) {
    SizeConfig().init(context);
  }

  static double appBarHeight = SizeConfig.blockSizeVertical * 5;
  static double bottomBarHeight = SizeConfig.blockSizeVertical * 6;
  static double itemHeight = SizeConfig.blockSizeVertical * 57;
  static double otherHeight = SizeConfig.blockSizeVertical * 15;
  static double playerMsgHeight = SizeConfig.blockSizeVertical * 15;

  static double itemWidth = SizeConfig.blockSizeHorizontal * 20;
  static double msgHeight = SizeConfig.blockSizeVertical * 43;
  static double roomHeight = SizeConfig.blockSizeVertical * 25;
  static double exitsHeight = SizeConfig.blockSizeVertical * 15;
  static double playerMsgWidth = SizeConfig.blockSizeHorizontal * 20;
  static double equipHeight = SizeConfig.blockSizeVertical * 35;
  static double bagHeight = SizeConfig.blockSizeVertical * 54;
  // static double bottomBarHeight = SizeConfig.blockSizeVertical;
  // static double appBarHeight = SizeConfig.blockSizeVertical;
  // static double bottomBarHeight = SizeConfig.blockSizeVertical;
  // static double appBarHeight = SizeConfig.blockSizeVertical;
  // static double bottomBarHeight = SizeConfig.blockSizeVertical;
  // static double appBarHeight = SizeConfig.blockSizeVertical;
  // static double bottomBarHeight = SizeConfig.blockSizeVertical;
}
