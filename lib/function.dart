import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

String msgSplit(String str, [double size, bool bl = true]) {
  String _msg = "";

  _msg = cssStyle(str, size, bl);

  _msg = _msg.replaceAll(
      RegExp(
          "<span><span><span><span><span><span><span><span><span></span><br/></p>"),
      "");

  return _msg;
}

String cssStyle(String str, [double size = 0.85, bool bl = false]) {
  int a = 0;
  int b = 0;

  if (str == null) {
    return "字符串为null";
  }
  if (bl) {
    str = str.replaceAll("<", "\[");
    str = str.replaceAll(">", "\]");
  }
  for (var i = 0; i < 8; i++) {
    str = "<span>" + str;
  }

  str = str.replaceAll("\$br#", "<br/>");
  str = str.trim();
  str = str.replaceAll("\"", "\'");
  str = str.replaceAll("[2;37;0m", "</span>");
  str = str.replaceAll("[256D", "");
  str = str.replaceAll("[K", "");
  str = str.trimLeft();
  str = str.trimRight();
  str = str.replaceAll(
      "[30m", "<span style = \"color:#000000\">"); /* Black    黑*/
  str = str.replaceAll(
      "[31m", "<span style = \"color:#800000\">"); /* Red      酱红*/
  str = str.replaceAll(
      "[32m", "<span style = \"color:#008000\">"); /* Green    浅绿*/
  str = str.replaceAll(
      "[33m", "<span style = \"color:#808000\">"); /* Yellow   黄褐*/
  str = str.replaceAll(
      "[34m", "<span style = \"color:#000080\">"); /* Blue     浅蓝*/
  str = str.replaceAll(
      "[35m", "<span style = \"color:#800080\">"); /* Magenta  紫色*/
  str = str.replaceAll(
      "[36m", "<span style = \"color:#008080\">"); /* Cyan     天蓝*/
  str = str.replaceAll(
      "[37m", "<span style = \"color:#ddddee\">"); /* White    灰白*/
  str = str.replaceAll(
      "[1;30m", "<span style = \"color:#5a5a5a\">"); /* Black    浅黑*/
  str = str.replaceAll(
      "[1;31m", "<span style = \"color:#ff0000\">"); /* Red      红色*/
  str = str.replaceAll(
      "[1;32m", "<span style = \"color:#00ff00\">"); /* Green    绿色*/
  str = str.replaceAll(
      "[1;33m", "<span style = \"color:#ffff00\">"); /* Yellow   黄色*/
  str = str.replaceAll(
      "[1;34m", "<span style = \"color:#0000ff\">"); /* Blue     蓝色*/
  str = str.replaceAll(
      "[1;35m", "<span style = \"color:#ff00ff\">"); /* Magenta  粉红*/
  str = str.replaceAll(
      "[1;36m", "<span style = \"color:#00ffff\">"); /* Cyan     青色*/
  str = str.replaceAll(
      "[1;37m", "<span style = \"color:#ffffff\">"); /* White    白色*/
  str = str.replaceAll("[1m", "<span style = \"color:#ffffee\">");

  Iterable matches = RegExp("<span style =").allMatches(str);
  for (var i = 0; i < matches.length; i++) {
    a++;
  }
  Iterable matches2 = RegExp("</span>").allMatches(str);
  for (var i = 0; i < matches2.length; i++) {
    b++;
  }
  if (a - b > 0) {
    int c = a - b;
    for (var i = 0; i < c; i++) {
      str += "</span>";
    }
  } else if (a - b < 0) {
    int c = b - a;
    for (var i = 0; i < c; i++) {
      str = "<span>" + str;
    }
  }
  if (str == "") {
    return "";
  }

  str =
      "<p style = \"font-size:${size}em;color:white;text-align:center;text-decoration:none\">" +
          str +
          "</p>";
  return str;
}

// class ChatNpcSpec {
//   BuildContext context;
//   String str = "";
//   ChatNpcSpec({this.context, this.str});
//   int r = 0, w = 0, h = 0, s = 0, _menuCount = 0;
//   Map _menuMap = Map();
//   List _menuBtn = List();
//   List<String> _menuList = List();
//   String string = "";
//   void analyse() {
//     Iterable<Match> _matches = RegExp("008(.+)").allMatches(str);
//     for (Match m1 in _matches) {
//       string += "${m1.group(0)}";
//     }
//     _menuList = string.split("\$M#");
//   }

//   List menu() {
//     _menuCount = 0;
//     _menuBtn = List();
//     _menuList[0] = _menuList[0].replaceAll(RegExp(r"008\$(.*)#"), "");
//     for (String split in _menuList) {
//       if (split.isEmpty) {
//         continue;
//       }
//       _menuMap = Map();
//       List<String> _split2 = split.split(":");
//       // print(_split2);
//       _menuMap["menuCmd"] = _split2[1];
//       _menuMap["menuTag"] = HTML.toRichText(context, msgSplit(_split2[0], 0.8));
//       _menuBtn.add(_menuMap);
//       _menuCount++;
//     }
//     return _menuBtn;
//   }

//   int count() {
//     menu();
//     return _menuCount;
//   }
// }

// class Channel {
//   String str;
//   BuildContext context;
//   Channel({this.context, this.str});
//   String _msg = "";
//   List _split = List();

//   String _info = "";
//   String _channelmsg;

//   String channelMsg() {
//     Iterable<Match> _matches = RegExp("100(.+)").allMatches(str);
//     for (Match m in _matches) {
//       _msg += "${m.group(0)}" + "\n";
//     }
//     if (_msg.isNotEmpty) {
//       _msg = _msg.replaceFirst("100", "");
//       _split = _msg.split("100");
//       for (var item in _split) {
//         _info += item;
//       }
//       _channelmsg = msgSplit(_info);
//     }
//     return _channelmsg;
//   }
// }

// class Toast {
//   final str;
//   Toast({this.str});
//   void show() {
//     String _toast;
//     Iterable<Match> matches = RegExp("901(.+)").allMatches(str);
//     for (Match m in matches) {
//       _toast = "${m.group(0)}";
//     }
//     if (_toast == null) {
//       return;
//     }
//     if (_toast.isNotEmpty && _toast != "") {
//       _toast = _toast.replaceAll("901", "");
//       showToast(_toast);
//       _toast = "";
//     }
//   }
// }

class Storage {
  static Future<bool> setdata(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, value);
    return true;
  }

  static Future<bool> setListdata(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList(key, value);
    return true;
  }

  static Future<String> getdata(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<List<String>> getListdata(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }
}
