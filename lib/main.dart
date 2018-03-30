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

  final Menu menu = new Menu(
    items: [
      new MenuItem(
        id: 'restaurant',
        title: 'THE PADDOCK',
      ),
      new MenuItem(
        id: 'other1',
        title: 'THE HERO',
      ),
      new MenuItem(
        id: 'other2',
        title: 'HELP US GROW',
      ),
      new MenuItem(
        id: 'other3',
        title: 'SETTINGS',
      ),
    ],
  );

  String selectedMenuItemId = 'restaurant';
  Screen activeScreen = restaurantScreen;

  @override
  Widget build(BuildContext context) {
    return new ZoomMenuScaffold(
      menuScreen: new MenuScreen(
        menu: menu,
        selectedMenuItemId: selectedMenuItemId,
        onMenuItemSelected: (menuItemId) {
          setState(() {
            selectedMenuItemId = menuItemId;

            if (selectedMenuItemId == 'restaurant') {
              activeScreen = restaurantScreen;
            } else {
              activeScreen = otherScreen;
            }
          });
        },
      ),
      contentScreen: activeScreen,
    );
  }
}