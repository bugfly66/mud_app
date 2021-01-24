import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mud_app/connect.dart';
import 'global.dart';
import 'pages/email_page.dart';
import 'pages/main_page.dart';
import 'module/toastListen.dart';
import 'pages/attribute_page.dart';
import 'pages/bag_page.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  // ignore: unused_field
  int _currentIndex = 0;
  PageController _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: Global.bottomBarHeight,
      //color: Colors.transparent,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/images/bottom.png")),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildBottomItem(
              title: '修仙', icon: AssetImage("assets/images/bg2.png"), index: 0),
          _buildBottomItem(
              title: '属性', icon: AssetImage("assets/images/bg2.png"), index: 1),
          _buildBottomItem(
              title: '储物', icon: AssetImage("assets/images/bg2.png"), index: 2),
          _buildBottomItem(
              title: '消息', icon: AssetImage("assets/images/bg2.png"), index: 3),
          _buildBottomItem(
              title: '我的', icon: AssetImage("assets/images/bg2.png"), index: 4),
        ],
      ),
    );
  }

  Widget _buildBottomItem({String title, AssetImage icon, int index}) {
    return Expanded(
      child: InkResponse(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.fitHeight, image: icon),
          ),
          alignment: Alignment.center,
          child: Text("$title"),
        ),
        onTap: () {
          _controller.jumpToPage(index);
          if (index == 2) {
            client.sendMsg("inventory0");
          }
          setState(() {
            _currentIndex = index;
          });
          // PageView 页面跳转
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover, image: AssetImage("assets/background.jpg")),
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, Global.appBarHeight),
          child: AppBar(
            elevation: 0.0,
            brightness: Brightness.values[0],
            toolbarHeight: Global.appBarHeight,
            backgroundColor: Colors.transparent,
            actions: [ToastListenButton()],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            PainterDemo(),
            AttriPage(),
            BagPage(),
            EmailScreen(),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }
}
