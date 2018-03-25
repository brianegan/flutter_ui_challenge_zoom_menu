import 'package:flutter/material.dart';
import 'package:zoom_menu/menu_screen.dart';
import 'package:zoom_menu/restaurant_screen.dart';
import 'package:zoom_menu/zoom_menu_scaffold.dart';

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

  @override
  Widget build(BuildContext context) {
    return new ZoomMenuScaffold(
      menuScreenBuilder: (context, menuController) {
        return new MenuScreen();
      },
      contentScreenBuilder: (context, menuController) {
        return new RestaurantScreen(
          menuController: menuController,
        );
      },
    );
  }
}
