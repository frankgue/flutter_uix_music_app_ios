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

class _StackBuilderState extends State<StackBuilder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
