import 'package:flutter/material.dart';
import '../connect.dart';
import '../sizeConfig.dart';

import '../global.dart';

class AttriPage extends StatefulWidget {
  @override
  _AttriPageState createState() => _AttriPageState();
}

class _AttriPageState extends State<AttriPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  List<Tab> myTabs = <Tab>[
    Tab(
      text: "人物",
    ),
    Tab(
      text: "肉身",
    ),
    Tab(
      text: "大道",
    ),
    Tab(
      text: "大道",
    )
  ];
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         fit: BoxFit.fill, image: AssetImage("assets/images/bg6.png")),
        //   ),
        // ),
        // toolbarHeight: Global.appBarHeight,
        // backgroundColor: Colors.transparent,
        preferredSize: Size(SizeConfig.screenWidth, Global.appBarHeight),
        child: TabBar(
          tabs: myTabs,
          controller: _tabController,
          onTap: (value) {
            client.sendMsg("attr$value\n");
          },
        ),
      ),
      body: TabBarView(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("assets/images/bg8.png")),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("assets/images/bg8.png")),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("assets/images/bg8.png")),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("assets/images/bg8.png")),
            ),
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}
