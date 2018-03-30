import 'package:flutter/material.dart';
import 'package:zoom_menu/menu.dart';
import 'package:zoom_menu/menu_screen.dart';
import 'package:zoom_menu/other_screen.dart';
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

  final Menu menu = new Menu(
    items: [
      new MenuItem(
        id: 'the_paddock',
        title: "THE PADDOCK",
      ),
      new MenuItem(
        id: 'the_hero',
        title: "THE HERO",
      ),
      new MenuItem(
        id: 'help_us_grow',
        title: "HELP US GROW",
      ),
      new MenuItem(
        id: 'settings',
        title: "SETTINGS",
      ),
    ],
  );

  String selectedMenuItemId;

  @override
  void initState() {
    super.initState();
    selectedMenuItemId = menu.items[0].id;
  }

  @override
  Widget build(BuildContext context) {
    return new ZoomMenuScaffold(
      menuScreenBuilder: (context, menuController) {
        return new MenuScreen(
          menu: menu,
          selectedMenuItemId: selectedMenuItemId,
          menuController: menuController,
          onMenuItemSelected: (newSelectedMenuItemId) {
            menuController.close();
            setState(() => selectedMenuItemId = newSelectedMenuItemId);
          },
        );
      },
      contentScreenBuilder: (context, menuController) {
        if (selectedMenuItemId == "the_paddock") {
          return new ContentScreen(
            title: 'THE PALEO PADDOCK',
            background: new DecorationImage(
              image: new AssetImage('assets/wood_bk.jpg'),
              fit: BoxFit.cover,
            ),
            content: new RestaurantScreenContent(),
          );
        } else {
          return new ContentScreen(
            title: 'OTHER SCREEN',
            background: new DecorationImage(
              image: new AssetImage('assets/space_bk.jpg'),
              fit: BoxFit.cover,
            ),
            content: new OtherScreen(),
          );
        }
      },
    );
  }
}

class ContentScreenChanger extends StatefulWidget {

  final MenuController menuController;

  ContentScreenChanger({
    this.menuController,
  });

  @override
  _ContentScreenChangerState createState() => new _ContentScreenChangerState();
}

class _ContentScreenChangerState extends State<ContentScreenChanger> {

  String selectedListItemId;


  @override
  void initState() {
    super.initState();
    widget.menuController.addListener(_onMenuControllerChange);
  }

  @override
  void dispose() {
    widget.menuController.removeListener(_onMenuControllerChange);
    super.dispose();
  }

  _onMenuControllerChange() {

  }

  @override
  Widget build(BuildContext context) {
    return new Container();
  }

}
