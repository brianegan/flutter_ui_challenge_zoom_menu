import 'package:flutter/material.dart';
import 'package:zoom_menu/menu_screen.dart';
import 'package:zoom_menu/restaurant_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Zoom Menu',
      theme: new ThemeData(
        brightness: Brightness.dark,
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

  Widget _scaleAndPositionContentScreen(contentScreen) {
    return new Transform(
      transform: new Matrix4
          .translationValues(250.0, 0.0, 0.0)
        ..scale(0.85, 0.85),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: const Color(0x44000000),
              offset: const Offset(0.0, 5.0),
              blurRadius: 20.0,
              spreadRadius: 10.0,
            )
          ],
        ),
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(10.0),
          child: contentScreen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Stack(
        children: [
          new MenuScreen(),
          _scaleAndPositionContentScreen(new RestaurantScreen()),
        ],
      ),
    );
  }
}
