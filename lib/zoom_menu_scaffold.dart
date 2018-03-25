import 'package:flutter/material.dart';

class ZoomMenuScaffold extends StatefulWidget {

  final Widget menuScreen;
  final Widget contentScreen;

  ZoomMenuScaffold({
    this.menuScreen,
    this.contentScreen,
  });

  @override
  _ZoomMenuScaffoldState createState() => new _ZoomMenuScaffoldState();
}

class _ZoomMenuScaffoldState extends State<ZoomMenuScaffold> {

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
          widget.menuScreen,
          _scaleAndPositionContentScreen(widget.contentScreen),
        ],
      ),
    );
  }
}
