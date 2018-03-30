import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ZoomMenuScaffold extends StatefulWidget {

  final Screen contentScreen;

  ZoomMenuScaffold({
    this.contentScreen,
  });

  @override
  _ZoomMenuScaffoldState createState() => new _ZoomMenuScaffoldState();
}

class _ZoomMenuScaffoldState extends State<ZoomMenuScaffold> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: widget.contentScreen.background,
      ),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {
                // TODO: open/close the menu
              }
          ),
          title: new Text(
            widget.contentScreen.title,
            style: new TextStyle(
              fontFamily: 'bebas-neue',
              fontSize: 25.0,
            ),
          ),
        ),
        body: widget.contentScreen.contentBuilder(context),
      ),
    );
  }
}


class Screen {
  final String title;
  final DecorationImage background;
  final WidgetBuilder contentBuilder;

  Screen({
    this.title,
    this.background,
    this.contentBuilder,
  });
}