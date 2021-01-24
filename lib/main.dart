import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'global.dart';
import 'module/noSplash.dart';
import 'pages/splashPage.dart';
import 'connect.dart';
import 'pages/login.dart';

void main() {
  //debugPaintSizeEnabled = true;

  runApp(MyApp());
  FirebaseAdMob.instance
      .initialize(appId: "ca-app-pub-6454060774191147~6616589057");

  client.watch();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: NoSplashFactory(),
        fontFamily: 'kaiti',
      ),
      builder: BotToastInit(), //BotToastInit移动到此处
      navigatorObservers: [BotToastNavigatorObserver()],
      // routes: <String, WidgetBuilder>{
      //   '/App': (BuildContext context) => App(),
      // },
      home: SplashPage(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Global.init(context);
    return Scaffold(
      body: Login(),
    );
  }
}
