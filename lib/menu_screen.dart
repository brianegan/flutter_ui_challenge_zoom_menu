import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: double.infinity,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/dark_grunge_bk.jpg'),
          fit: BoxFit.cover,
        ),
        color: Colors.transparent,
      ),
      child: new Stack(
        children: [
          new Transform(
            transform: new Matrix4.translationValues(-100.0, 0.0, 0.0),
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
          ),
          new Transform(
            transform: new Matrix4.translationValues(0.0, 250.0, 0.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new _MenuItem(
                  title: 'THE PADDOCK',
                  isSelected: true,
                ),
                new _MenuItem(
                  title: 'THE HERD',
                  isSelected: false,
                ),
                new _MenuItem(
                  title: 'HELP US GROW',
                  isSelected: false,
                ),
                new _MenuItem(
                  title: 'SETTINGS',
                  isSelected: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _MenuItem extends StatelessWidget {

  final title;
  final isSelected;

  _MenuItem({
    this.title,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
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
    );
  }
}