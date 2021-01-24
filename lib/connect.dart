import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:event_bus/event_bus.dart';

final String check = "QHNlY3JldCV1OUE4QyV1OEJDMQ==";

class Mudclient {
  IOWebSocketChannel _channel = IOWebSocketChannel.connect(
    "ws://59.110.225.114:5678",
    protocols: {"ascii"},
  );

  Future<void> sendMsg(String str) async {
    print("$str");
    if (str.isNotEmpty) {
      _channel.sink.add(utf8.encode(str + "\n"));
    }
  }

  watch() {
    _channel.stream.listen((message) {
      var temp = utf8.decode(message);
      Map jsonMap;
      List jsonList;
      print("temp:$message");
      jsonList = temp.split("\$sp#");
      jsonList.forEach((element) {
        if (element != "") {
          print(
              "###################################\n$element\n#################################\n");
          if (RegExp("\{\"").firstMatch(element) != null) {
            jsonMap = json.decode(element);
            //print("json格式字符串：$element");
            eventBus.fire(DataChange(data: jsonMap));
          } else {
            element = element.replaceAll(RegExp("\n"), "<br/>");
            element = element.replaceAll(RegExp(""), "<br/>");
            String tmp = "{\"msg\":\"" + element + "\"}";
            //print("非json格式字符串：" + tmp);
            jsonMap = json.decode(tmp);
            eventBus.fire(DataChange(data: jsonMap));
          }
        }
      });
    });
  }

  void disconnect() {
    _channel.sink.close();
  }
}

var client = new Mudclient();

EventBus eventBus = new EventBus();

class DataChange {
  Map data;
  DataChange({this.data});
}
