import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ZoomMenuScaffold extends StatefulWidget {

  final Widget menuScreen;
  final Screen contentScreen;

  ZoomMenuScaffold({
    this.menuScreen,
    this.contentScreen,
  });

  @override
  _ZoomMenuScaffoldState createState() => new _ZoomMenuScaffoldState();
}

class _ZoomMenuScaffoldState extends State<ZoomMenuScaffold> {

  _createContentDisplay() {
    return _zoomAndSlideContent(
        Container(
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
        ),
    );
  }

  _zoomAndSlideContent(Widget content) {
    return new Transform(
      transform: new Matrix4
        .translationValues(275.0, 0.0, 0.0)
        ..scale(0.8, 0.8),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: const Color(0x44000000),
              offset: const Offset(0.0, 5.0),
              blurRadius: 20.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(10.0),
          child: content
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.menuScreen,
        _createContentDisplay(),
      ],
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