import 'package:flutter/material.dart';

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

class StackBuilder extends StatefulWidget{
   StackBuilder({Key key}) : super(key: key);
  @override
  _StackBuilderState createState() => _StackBuilderState();

}

class _StackBuilderState extends State<StackBuilder> with TickerProviderStateMixin{

  AnimationController  paneController;
  Animation<double> paneAnimation;
  bool isAnimCompleted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    paneController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    paneAnimation = Tween<double>(begin: -250, end: 0.0).animate(paneController);

  }

  animationInit(){
    if(isAnimCompleted){
      paneController.reverse();
    }else{
      paneController.forward();
    }
    isAnimCompleted = !isAnimCompleted;
  }


  Widget stackBody(BuildContext context){
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(image: DecorationImage(image: ExactAssetImage('assets/sale.png'))),
        ),
        Positioned(
          bottom: paneAnimation.value,
          child: GestureDetector(
            onTap: () {
             animationInit();
            },
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
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
        builder: (BuildContext context, widget){
          return stackBody(context);
        },
      ),
    );
  }
}
