import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fun.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static String lang = "en";

  static SharedPreferences prefs;
  static final int iCP1 = 0xFF45AAFF;
  static final Color cp1 = Color(iCP1), bgColor = Color(0xFFFFFFFF);
  static final Map<Nav, String> routeMap = {Nav.Intro: '/', Nav.Menu: '/menu'};

  static Future<void> preparePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Hisabat',
      theme: ThemeData(
        primarySwatch:
            MaterialColor(iCP1, materialColorMap(cp1.red, cp1.green, cp1.blue)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: route(Nav.Intro),
      // Warning: When using initialRoute, don’t define a home property.
      routes: {
        routeMap[Nav.Intro]: (context) => route(Nav.Intro),
        routeMap[Nav.Menu]: (context) => route(Nav.Menu),
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', ''), const Locale('ar', '')],
    );
  }
}

enum Nav { Intro, Menu }

class Template extends StatelessWidget {
  Template({this.header, this.main});

  final Widget header, main; // A variable is "null" if not initialized.

  @override
  Widget build(BuildContext c) {
    Widget wHeader = Container(), wMain = Container();
    if (header != null) wHeader = header;
    if (main != null) wMain = main;

    return Column(
      children: [
        Expanded(
          flex: 373,
          child: ClipOval(
            clipper: PageTopClipper(),
            child: Container(
              decoration: BoxDecoration(gradient: primaryGradient1()),
              child: wHeader,
            ),
          ),
        ),
        Expanded(
          flex: 627,
          child: Padding(
            padding: EdgeInsets.only(top: 50, bottom: 10),
            child: wMain,
          ),
        )
      ],
    );
  }
}
