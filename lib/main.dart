import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: restaurantScreen.background,
      ),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () {
              // TODO: open/close the menu
            }
          ),
          title: new Text(
            restaurantScreen.title,
            style: new TextStyle(
              fontFamily: 'bebas-neue',
              fontSize: 25.0,
            ),
          ),
        ),
        body: restaurantScreen.contentBuilder(context),
      ),
    );
  }
}