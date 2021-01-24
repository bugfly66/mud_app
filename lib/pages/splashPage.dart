import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mud_app/main.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isStartHomePage = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: goToHomePage,
      child: Image.network(
          "http://pic.netbian.com/uploads/allimg/210110/223105-16102890650508.jpg"),
    );
  }

  @override
  void initState() {
    super.initState();
    countDown();
  }

  void countDown() {
    Future.delayed(Duration(seconds: 5), goToHomePage);
  }

  void goToHomePage() {
    if (!isStartHomePage) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => App()), (route) => false);
      isStartHomePage = true;
    }
  }
}
