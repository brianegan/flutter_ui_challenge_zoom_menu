import 'package:flutter/material.dart';
import 'package:zoom_menu/other_screen.dart';
import 'package:zoom_menu/restaurant_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Zoom Menu',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var activeScreen = restaurantScreen;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        image: activeScreen.background,
      ),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {
                // TODO:
              }
          ),
          title: new Text(
            activeScreen.title,
            style: new TextStyle(
              fontFamily: 'bebas-neue',
              fontSize: 25.0,
            ),
          ),
        ),
        body: activeScreen.contentBuilder(context),
      ),
    );
  }
}

