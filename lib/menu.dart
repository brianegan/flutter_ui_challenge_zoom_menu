import 'package:flutter/widgets.dart';

class Menu {
  final List<MenuItem> menuItems;

  Menu({this.menuItems});
}

class MenuItem {
  final String title;
  final ScreenBuilder screenBuilder;

  MenuItem({
    this.title,
    this.screenBuilder,
  });
}

class ScreenBuilder {
  final Function(BuildContext) backgroundBuilder;
  final Function(BuildContext) contentBuilder;

  ScreenBuilder({
    this.backgroundBuilder,
    this.contentBuilder,
  });
}