import 'package:flutter/material.dart';
import 'main.dart';
import 'fun.dart';

class MyMenu extends StatefulWidget {
  @override
  State createState() => MyMenuState();
}

class MyMenuState extends State<MyMenu> {
  @override
  Widget build(BuildContext c) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: MyApp.bgColor,
        body: Stack(
          children: [
            Template(),
            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: .0698,
                child: Container(
                  decoration: BoxDecoration(
                    color: MyApp.bgColor,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x226A99FC),
                        spreadRadius: 6,
                        blurRadius: 7,
                        offset: Offset(0, -2)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
