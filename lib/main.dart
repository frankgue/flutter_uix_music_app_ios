import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttermusicui/progressbar.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StackBuilder(),
      ),
    );
  }
}

class StackBuilder extends StatefulWidget {
  StackBuilder({Key key}) : super(key: key);

  @override
  _StackBuilderState createState() => _StackBuilderState();
}

class _StackBuilderState extends State<StackBuilder>
    with TickerProviderStateMixin {
  AnimationController paneController;
  AnimationController playPauseController;
  AnimationController songCompletedController;
  Animation<double> paneAnimation;
  Animation<double> albumImageAnimation;
  Animation<double> albumImageBlurAnimation;
  Animation<Color> songContainerColorAnimation;
  Animation<Color> songContainerTextColorAnimation;
  Animation<double> songCompletedAnimation;

  bool isAnimCompleted = false;
  bool isSongPlaying = false;

  double songCompleted = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    paneController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    songCompletedController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 360))..addListener(() {
          setState(() {
            songCompleted = songCompletedAnimation.value;
          });
        });
    paneAnimation = Tween<double>(begin: -300, end: 0.0)
        .animate(CurvedAnimation(parent: paneController, curve: Curves.easeIn));
    albumImageAnimation = Tween<double>(begin: 1.0, end: 0.5)
        .animate(CurvedAnimation(parent: paneController, curve: Curves.easeIn));
    albumImageBlurAnimation = Tween<double>(begin: 0.0, end: 10.0)
        .animate(CurvedAnimation(parent: paneController, curve: Curves.easeIn));
    songContainerColorAnimation =
        ColorTween(begin: Colors.black87, end: Colors.white.withOpacity(0.5))
            .animate(paneController);
    songContainerTextColorAnimation =
        ColorTween(begin: Colors.white, end: Colors.black87)
            .animate(paneController);

    playPauseController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));


    songCompletedAnimation = Tween<double>(begin: 0.0, end: 400).animate(songCompletedController);
  }

  animationInit() {
    if (isAnimCompleted) {
      paneController.reverse();
    } else {
      paneController.forward();
    }
    isAnimCompleted = !isAnimCompleted;
  }

  playSong() {
    if (isSongPlaying) {
      playPauseController.reverse();
    } else {
      playPauseController.forward();
    }
    isSongPlaying = !isSongPlaying;
  }

  Widget stackBody(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: albumImageAnimation.value,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage('assets/dev.png'),
                    fit: BoxFit.cover)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: albumImageBlurAnimation.value,
                  sigmaY: albumImageBlurAnimation.value),
              child: Container(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: paneAnimation.value,
          child: GestureDetector(
            onTap: () {
              animationInit();
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: songContainerColorAnimation.value,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Now Playing",
                      style: TextStyle(
                          color: songContainerTextColorAnimation.value),
                    ),
                  ),
                  Text(
                    "Detecteur De Gue, Petit Bozard",
                    style: TextStyle(
                        color: songContainerTextColorAnimation.value,
                        fontSize: 16.0),
                  ),
                  Text(
                    "GKFC Solutions",
                    style: TextStyle(
                        color: songContainerTextColorAnimation.value,
                        fontSize: 12.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: CustomPaint(
                        painter:
                            ProgressBar(progressBarColor: songContainerTextColorAnimation.value, songCompleted: songCompletedAnimation.value),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.skip_previous,
                            size: 40.0,
                            color: songContainerTextColorAnimation.value),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              playSong();
                            },
                            child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: playPauseController,
                              color: songContainerTextColorAnimation.value,
                              size: 40.0,
                            ),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: Icon(Icons.skip_previous,
                              size: 40.0,
                              color: songContainerTextColorAnimation.value),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (BuildContext context, index) {
                          return Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              ExactAssetImage('assets/dev.png'),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Another Song Name",
                                    style: TextStyle(
                                      color:
                                          songContainerTextColorAnimation.value,
                                    ),
                                  ),
                                  Text(
                                    "Singer Name | 3:55",
                                    style: TextStyle(
                                      color:
                                          songContainerTextColorAnimation.value,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
        animation: paneController,
        builder: (BuildContext context, widget) {
          return stackBody(context);
        },
      ),
    );
  }
}
