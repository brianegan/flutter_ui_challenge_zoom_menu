import 'package:flutter/material.dart';
import 'package:zoom_menu/menu.dart';
import 'package:zoom_menu/restaurant_list_screen.dart';
import 'package:zoom_menu/zoom_scaffold.dart';

void main() => runApp(new MyApp());

final paleoPaddockMenu = new Menu(
  menuItems: [
    new MenuItem(
      title: 'THE PADDOCK',
      screenBuilder: new ScreenBuilder(
        backgroundBuilder: (BuildContext context) {
          return new Container();
        },
        contentBuilder: (BuildContext context) {
          return new RestaurantListScreen(
            isZoomedOut: false,
            onMenuTap: () {},
          );
        },
      ),
    ),

    new MenuItem(
      title: 'THE HERO',
      screenBuilder: new ScreenBuilder(
        backgroundBuilder: (BuildContext context) {
          return new Container();
        },
        contentBuilder: (BuildContext context) {
          return new Container();
        },
      ),
    ),

    new MenuItem(
      title: 'HELP US GROW',
      screenBuilder: new ScreenBuilder(
        backgroundBuilder: (BuildContext context) {
          return new Container();
        },
        contentBuilder: (BuildContext context) {
          return new Container();
        },
      ),
    ),

    new MenuItem(
      title: 'SETTINGS',
      screenBuilder: new ScreenBuilder(
        backgroundBuilder: (BuildContext context) {
          return new Container();
        },
        contentBuilder: (BuildContext context) {
          return new Container();
        },
      ),
    ),
  ]
);

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
    return new Scaffold(
      body: new ZoomScaffold(

      ),
    );
  }
}