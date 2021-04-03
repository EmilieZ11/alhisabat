import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'main.dart';
import 'fun.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  static String exShowedIntro = "showedIntro";
  static int which = 0;
  static final GlobalKey gKey = GlobalKey(), kSubmit = GlobalKey();

  // Intro
  static List<AnimationController> anRDList = List<AnimationController>();
  static int introIndex = 0;
  static CarouselController sliderController = CarouselController();
  static List<AnimationController> anLottieList = List<AnimationController>();

  // Signing

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    MyApp.preparePrefs().then((value) {
      //MyApp.prefs.setBool(MyHomePage.exShowedIntro, false);
      MyHomePage.which =
          (MyApp.prefs.getBool(MyHomePage.exShowedIntro) ?? false) ? 2 : 1;
      // ignore: invalid_use_of_protected_member
      MyHomePage.gKey.currentState.setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext c) {
    MyApp.lang = Localizations.localeOf(context).languageCode;
    Widget body;
    switch (MyHomePage.which) {
      case 1:
        body = intro(c);
        break;
      case 2:
        body = signing(c);
        break;
      default: // 0
        body = Center(
          child: CircularProgressIndicator(
            strokeWidth: 6,
            valueColor: AlwaysStoppedAnimation<Color>(MyApp.cp1),
          ),
        );
        break;
    }
    return WillPopScope(
      onWillPop: () async {
        if (MyHomePage.which == 1) {
          if (MyHomePage.introIndex != 0)
            MyHomePage.sliderController.previousPage();
          return MyHomePage.introIndex == 0;
        } else
          return true; // Returning true allows the pop to happen, returning false prevents it.
      },
      child: Scaffold(
        backgroundColor: MyApp.bgColor,
        body: body,
      ),
    );
  }
}

Widget intro(BuildContext c) {
  final Color colNext = MyApp.cp1;
  double shineBoxW = perW(c, 1), shineBoxH = perH(c, .69) * .1935;
  final introList = [1, 2, 3, 4, 5, 6];
  final kIntroText = GlobalKey();

  Future.delayed(Duration(milliseconds: 100), () {
    if (MyHomePage.anRDList != null && MyHomePage.anRDList.isNotEmpty)
      MyHomePage.anRDList[0].animateTo(1);
    if (MyHomePage.anLottieList != null && MyHomePage.anLottieList.isNotEmpty)
      MyHomePage.anLottieList[0].forward();
  });

  Widget shineImg(double opacity) => Opacity(
        opacity: opacity,
        child: Image.asset("assets/img/circle_white_1.png", fit: BoxFit.fill),
      );

  Future<void> introShowed() async {
    await MyApp.prefs.setBool(MyHomePage.exShowedIntro, true);
  }

  return Column(
    children: [
      Expanded(
        flex: 69,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF88E0FD), Color(0xFF7AB9FC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border(
              bottom: BorderSide(color: Color(0xFF7AB9FC), width: 1),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: perH(c, .69) * .721739,
                  bottom: perH(c, .69) * .034782,
                ),
                width: shineBoxW,
                height: shineBoxH,
                child: Stack(
                  children: <Widget>[
                    ClipOval(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: shineBoxW * .005333,
                          top: shineBoxH * 0,
                          right: shineBoxW * .025333,
                          bottom: shineBoxH * 0,
                        ),
                        width: shineBoxW * .969334,
                        height: shineBoxH * 1,
                        child: shineImg(.09),
                      ),
                    ),
                    ClipOval(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: shineBoxW * .113333,
                          top: shineBoxH * .134831,
                          right: shineBoxW * .141333,
                          bottom: shineBoxH * .140449,
                        ),
                        width: shineBoxW * .745334,
                        height: shineBoxH * .724720,
                        child: shineImg(.20),
                      ),
                    ),
                    ClipOval(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: shineBoxW * .223999,
                          top: shineBoxH * .314607,
                          right: shineBoxW * .214666,
                          bottom: shineBoxH * .247191,
                        ),
                        width: shineBoxW * .561335,
                        height: shineBoxH * .438202,
                        child: shineImg(.17),
                      ),
                    ),
                    ClipOval(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: shineBoxW * .271999,
                          top: shineBoxH * .421348,
                          right: shineBoxW * .275999,
                          bottom: shineBoxH * .370787,
                        ),
                        width: shineBoxW * .452002,
                        height: shineBoxH * .207865,
                        child: shineImg(.30),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: perH(c, .69) * .435),
                child: Image.asset("assets/img/hologram_1.png"),
              ),
              Container(
                margin: EdgeInsets.only(top: perH(c, .026237)),
                child: CarouselSlider(
                  carouselController: MyHomePage.sliderController,
                  options: CarouselOptions(
                    aspectRatio: 750 / 670,
                    height: perH(c, .552249),
                    //.502249
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      MyHomePage.introIndex = index;
                      // ignore: invalid_use_of_protected_member
                      kIntroText.currentState.setState(() {});
                      for (int cc = 0; cc < MyHomePage.anRDList.length; cc++)
                        MyHomePage.anRDList[cc]
                            .animateTo((cc == index) ? 1 : 0);
                      for (int l = 0; l < MyHomePage.anLottieList.length; l++) {
                        if (l == index) {
                          if (!MyHomePage.anLottieList[l].isAnimating)
                            MyHomePage.anLottieList[l].forward();
                        } else if (MyHomePage.anLottieList[l].isAnimating)
                          MyHomePage.anLottieList[l].stop();
                      }
                    },
                  ),
                  items: introList
                      .map((i) => Builder(
                          builder: (BuildContext c) => IntroSlide(i: i)))
                      .toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: perH(c, .69) * .925),
                child: Center(
                  child: IntroText(key: kIntroText),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 9,
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF7AB9FC), width: 1)),
          ),
          child: Image.asset("assets/img/intro_wave_2.jpg", fit: BoxFit.fill),
        ),
      ),
      Expanded(
        flex: 22,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: introList.map((i) {
                return Builder(builder: (BuildContext c) => RedDot(num: i));
              }).toList(),
            ),
            GestureDetector(
              onTap: () {
                if (MyHomePage.introIndex == introList.length - 1) {
                  MyHomePage.which = 2;
                  introShowed().then((value) {
                    // ignore: invalid_use_of_protected_member
                    MyHomePage.gKey.currentState.setState(() {});
                  });
                } else
                  MyHomePage.sliderController
                      .nextPage(duration: Duration(milliseconds: 480));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 5.5),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: colNext),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                child: Text(
                  str("iNext"),
                  style: TextStyle(color: colNext, fontSize: 19),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class RedDot extends StatefulWidget {
  RedDot({Key key, this.num}) : super(key: key);
  final int num;

  @override
  RedDotState createState() => RedDotState();
}

class RedDotState extends State<RedDot> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 222),
    );
    MyHomePage.anRDList.add(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = 12;
    final Color dotsRed = Color(0xFFFA5A5C);

    return Container(
      width: size,
      height: size,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: DecoratedBoxTransition(
        decoration: DecorationTween(
          begin: BoxDecoration(
            color: Color(0xFFE8E8E8),
            border: Border.all(width: 2, color: MyApp.bgColor),
            borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          ),
          end: BoxDecoration(
            gradient: RadialGradient(
              colors: [dotsRed, dotsRed, Color(0x00FA5A5C)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          ),
        ).animate(_controller),
        child: Center(),
      ),
    );
  }
}

class IntroText extends StatefulWidget {
  IntroText({Key key}) : super(key: key);

  @override
  State createState() => IntroTextState();
}

class IntroTextState extends State<IntroText> {
  @override
  Widget build(BuildContext c) {
    return Text(
      str("intro" + (MyHomePage.introIndex + 1).toString()),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 20, color: Colors.white),
    );
  }
}

class IntroSlide extends StatefulWidget {
  IntroSlide({Key key, this.i}) : super(key: key);
  final int i;

  @override
  State createState() => IntroSlideState();
}

class IntroSlideState extends State<IntroSlide> with TickerProviderStateMixin {
  @override
  void initState() {
    AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller.repeat();
    });
    MyHomePage.anLottieList.add(_controller);
    super.initState();
  }

  @override
  void dispose() {
    //MyHomePage.anLottieList[widget.i - 1].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext c) {
    String name = 'intro_' + widget.i.toString();
    return (widget.i <= 3)
        ? Lottie.asset(
            'assets/lottie/' + name + '.json',
            controller: MyHomePage.anLottieList[widget.i - 1],
          )
        : Image.asset('assets/img/' + name + '.png');
  }
}

Widget signing(BuildContext c) {
  final radius1 = BorderRadius.all(Radius.circular(25)),
      colField = Color(0xFFB0B0B0),
      fieldStyle = TextStyle(color: Color(0xFF707070), fontSize: 16),
      fieldHintStyle = TextStyle(color: colField, fontSize: 16);

  return Stack(
    children: [
      Template(
        main: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FractionallySizedBox(
              widthFactor: .639,
              child: TextField(
                controller: Submit.edUser,
                decoration: InputDecoration(
                  hintText: str('signUser'),
                  hintStyle: fieldHintStyle,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  fillColor: colField,
                ),
                style: fieldStyle,
              ),
            ),
            FractionallySizedBox(
              widthFactor: .639,
              child: Padding(
                padding: EdgeInsets.only(top: 30, bottom: 70),
                child: TextField(
                  controller: Submit.edPass,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: str('signPass'),
                    hintStyle: fieldHintStyle,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    fillColor: colField,
                  ),
                  style: fieldStyle,
                ),
              ),
            ),
            Submit(key: MyHomePage.kSubmit, radius: radius1),
          ],
        ),
      ),
      Align(
        alignment: Alignment(0, -0.85),
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: .25,
          child: Image.asset("assets/img/login_logo_1.png"),
        ),
      ),
      Align(
        alignment: Alignment(0, -0.29),
        child: FractionallySizedBox(
          widthFactor: .66,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: radius1,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.14),
                  spreadRadius: 7,
                  blurRadius: 15,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: SignToggle(radius: radius1),
          ),
        ),
      ),
    ],
  );
}

class SignToggle extends StatefulWidget {
  SignToggle({Key key, this.radius}) : super(key: key);
  final BorderRadius radius;

  @override
  State createState() => SignToggleState();
}

class SignToggleState extends State<SignToggle> {
  static bool isLogin = true;

  @override
  Widget build(BuildContext c) {
    return Stack(
      children: [
        Container(
          child: AnimatedAlign(
            alignment: isLogin ? Alignment.centerLeft : Alignment.centerRight,
            curve: Curves.ease,
            duration: Duration(milliseconds: 300),
            child: FractionallySizedBox(
              widthFactor: 0.55,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: widget.radius,
                  gradient: primaryGradient1(),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isLogin = true;
            });
            MyHomePage.kSubmit.currentState.setState(() {});
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                child: Align(
                  alignment: Alignment(0.15, 0),
                  child: Text(
                    str("login"),
                    style: TextStyle(
                      color: Color(isLogin ? 0xFFFFFFFF : 0xFF808080),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isLogin = false;
            });
            MyHomePage.kSubmit.currentState.setState(() {});
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                child: Align(
                  alignment: Alignment(-0.1, 0),
                  child: Text(
                    str("signUp"),
                    style: TextStyle(
                      color: Color(isLogin ? 0xFF808080 : 0xFFFFFFFF),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Submit extends StatefulWidget {
  Submit({Key key, this.radius}) : super(key: key);
  final BorderRadius radius;

  static final TextEditingController edUser = TextEditingController(),
      edPass = TextEditingController();

  @override
  State createState() => SubmitState();
}

class SubmitState extends State<Submit> {
  String name;

  @override
  Widget build(BuildContext c) {
    return GestureDetector(
      onTap: () {
        goTo(c, Nav.Menu, popUntil: true);
      },
      child: FractionallySizedBox(
        widthFactor: .48,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: widget.radius,
            gradient: primaryGradient1(),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Text(
              str(SignToggleState.isLogin ? "login" : "signUp"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
