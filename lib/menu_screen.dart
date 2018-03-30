import 'package:flutter/material.dart';
import 'package:zoom_menu/zoom_scaffold.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => new _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  _createMenuTitle() {
    return new Transform(
      transform: new Matrix4.translationValues(
          -100.0,
          0.0,
          0.0
      ),
      child: new OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment.topLeft,
        child: new Padding(
          padding: const EdgeInsets.all(30.0),
          child: new Text(
            'Menu',
            style: new TextStyle(
              color: const Color(0x88444444),
              fontSize: 240.0,
              fontFamily: 'mermaid',
            ),
            textAlign: TextAlign.left,
            softWrap: false,
          ),
        ),
      ),
    );
  }

  _createMenuList(MenuController menuController) {
    return new Column(
      children: [
        new _MenuListItem(
          title: 'THE PADDOCK',
          isSelected: true,
          onTap: () {
            menuController.close();
          },
        ),
        new _MenuListItem(
          title: 'THE HERO',
          isSelected: false,
          onTap: () {
            menuController.close();
          },
        ),
        new _MenuListItem(
          title: 'HELP US GROW',
          isSelected: false,
          onTap: () {
            menuController.close();
          },
        ),
        new _MenuListItem(
          title: 'SETTINGS',
          isSelected: false,
          onTap: () {
            menuController.close();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffoldMenuController(
      builder: (BuildContext context, MenuController menuController) {
        return new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/dark_grunge_bk.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: new Material(
            color: Colors.transparent,
            child: new Stack(
              children: [
                _createMenuTitle(),

                new Transform(
                  transform: new Matrix4.translationValues(0.0, 225.0, 0.0),
                  child: _createMenuList(menuController),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MenuListItem extends StatelessWidget {

  final String title;
  final bool isSelected;
  final Function() onTap;

  _MenuListItem({
    this.title,
    this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: const Color(0x44000000),
      onTap: isSelected ? null : onTap,
      child: new Container(
        width: double.infinity,
        child: new Padding(
          padding: const EdgeInsets.only(left: 50.0, top: 15.0, bottom: 15.0),
          child: new Text(
            title,
            style: new TextStyle(
              color: isSelected ? Colors.red : Colors.white,
              fontSize: 25.0,
              fontFamily: 'bebas-neue',
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
