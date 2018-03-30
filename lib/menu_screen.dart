import 'package:flutter/material.dart';

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

  _createMenuList() {
    return new Container();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/dark_grunge_bk.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(
          children: [
            _createMenuTitle(),
            _createMenuList(),
          ],
        ),
      ),
    );
  }
}
