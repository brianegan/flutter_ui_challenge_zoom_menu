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
  final List<MenuScreenHistoryEntry> _history = [
    new MenuScreenHistoryEntry(
      restaurantScreen,
      MenuItemId.restaurant,
    )
  ];

  final menu = new Menu(
    items: [
      new MenuItem(
        id: MenuItemId.restaurant,
        title: 'THE PADDOCK',
      ),
      new MenuItem(
        id: MenuItemId.other1,
        title: 'THE HERO',
      ),
      new MenuItem(
        id: MenuItemId.other2,
        title: 'HELP US GROW',
      ),
      new MenuItem(
        id: MenuItemId.other3,
        title: 'SETTINGS',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffold(
      menuScreen: new MenuScreen(
        menu: menu,
        selectedItemId: _history.last.id,
        onMenuItemSelected: _pushPage,
      ),
      contentScreen: _history.last.screen,
    );
  }

  void _pushPage(MenuItem item) {
    setState(() {
      final route = ModalRoute.of(context);
      final entry = new LocalHistoryEntry(onRemove: _popPage);
      route.addLocalHistoryEntry(entry);

      switch (item.id) {
        case MenuItemId.restaurant:
          _history.add(new MenuScreenHistoryEntry(
            restaurantScreen,
            item.id,
          ));
          break;
        default:
          _history.add(new MenuScreenHistoryEntry(
            buildOtherScreen(item.title),
            item.id,
          ));
      }
    });
  }

  void _popPage() {
    setState(() {
      _history.removeLast();
    });
  }
}

class MenuScreenHistoryEntry {
  final Screen screen;
  final MenuItemId id;

  MenuScreenHistoryEntry(this.screen, this.id);
}
