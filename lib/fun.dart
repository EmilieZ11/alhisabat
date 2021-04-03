import 'package:flutter/material.dart';
import 'main.dart';
import 'intro.dart';
import 'menu.dart';
import 'strings.dart';

String str(String id) =>
    strings[MyApp.lang].containsKey(id) ? strings[MyApp.lang][id] : "undefined";

String capitalize(String str) {
  var split = str.split(' ');
  var sb = new StringBuffer();
  for (var s = 0; s < split.length; s++)
    sb.write(split[s].substring(0, 1).toUpperCase() +
        split[s].substring(1) +
        (s == split.length - 1 ? ' ' : ''));
  return sb.toString();
}

double perW(BuildContext c, double d) => MediaQuery.of(c).size.width * d;

double perH(BuildContext c, double d) => MediaQuery.of(c).size.height * d;

Map<int, Color> materialColorMap(int r, int g, int b) => {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };

class PageTopClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(size.width * -0.35,
      size.height * -0.1, size.width * 1.7, size.height * 1.1);

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}

LinearGradient primaryGradient1() => LinearGradient(
      colors: [Color(0xFF80C1FF), Color(0xFF9EE9FF)],
      begin: FractionalOffset.centerLeft,
      end: FractionalOffset.centerRight,
    );

Future goTo(BuildContext c, Nav nav, {bool popUntil = false}) {
  //Navigator.of(c).push(MaterialPageRoute<void>(builder: (context) => route(nav)));
  if (!popUntil)
    return Navigator.pushNamed(c, MyApp.routeMap[nav]);
  else
    return Navigator.pushNamedAndRemoveUntil(
        c, MyApp.routeMap[nav], (route) => false);
  // To remove all the routes below the pushed route,
  // use a RoutePredicate that always returns false.
}

Widget route(Nav nav) {
  switch (nav) {
    case Nav.Menu:
      return MyMenu();
    default:
      return MyHomePage(key: MyHomePage.gKey);
  }
}
