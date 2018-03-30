import 'package:flutter/material.dart';
import 'package:zoom_menu/menu_screen.dart';
import 'package:zoom_menu/other_screen.dart';
import 'package:zoom_menu/restaurant_screen.dart';
import 'package:zoom_menu/zoom_scaffold.dart';

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

  Screen activeScreen = restaurantScreen;

  @override
  Widget build(BuildContext context) {
    return new ZoomMenuScaffold(
      menuScreen: new MenuScreen(),
      contentScreen: activeScreen,
    );
  }
}