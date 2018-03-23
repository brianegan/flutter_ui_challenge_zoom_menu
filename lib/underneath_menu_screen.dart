import 'package:flutter/material.dart';

class UnderneathMenuScreen extends StatefulWidget {

  final double menuOpenPercent;
  final bool isMenuOpening;

  UnderneathMenuScreen({
    this.menuOpenPercent = 1.0,
    this.isMenuOpening = true,
  });

  @override
  _UnderneathMenuScreenState createState() => new _UnderneathMenuScreenState();
}

class _UnderneathMenuScreenState extends State<UnderneathMenuScreen> with TickerProviderStateMixin {

  final Interval titleAnimationOpenCurve = new Interval(0.0, 0.5);
  final Interval titleAnimationCloseCurve = new Interval(0.5, 1.0);

  @override
  Widget build(BuildContext context) {
    final menuTitlePercent = Curves.easeOut.transform(
        widget.isMenuOpening
            ? titleAnimationOpenCurve.transform(widget.menuOpenPercent)
            : titleAnimationCloseCurve.transform(widget.menuOpenPercent)
    );
    final menuTitlePosition = -75.0 + (300.0 * (1.0 - menuTitlePercent));

    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/dark_grunge_bk.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: new Stack(
        children: [
          // Menu text
          new Transform(
            transform: new Matrix4.translationValues(menuTitlePosition, 0.0, 0.0),
            child: new OverflowBox(
              alignment: Alignment.topLeft,
              maxWidth: double.INFINITY,
              child: new Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: new Text(
                  "Menu",
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
          // List of menu links
          new _Menu(
            menuOpenPercent: widget.menuOpenPercent,
            isMenuOpening: widget.isMenuOpening,
          ),
          // Debug animation controls
//          new Column(
//            children: [
//              new Expanded(
//                child: new Container(),
//              ),
//              new RaisedButton(
//                child: new Text('Play'),
//                onPressed: () {
//                  animationController.forward(from: 0.0);
//                }
//              ),
//              new Slider(
//                  value: transitionPercent,
//                  onChanged: (newValue) {
//                    setState(() => transitionPercent = newValue);
//                  }
//              ),
//            ],
//          )
        ],
      ),
    );
  }
}

class _Menu extends StatelessWidget {

  final double menuOpenPercent;
  final bool isMenuOpening;

  final Interval selectorSlideOpenCurve = new Interval(0.0, 0.45);
  final Interval selectorOpacityOpenCurve = new Interval(0.3, 0.9);
  final Interval selectorSlideCloseCurve = new Interval(0.55, 1.0);
  final Interval selectorOpacityCloseCurve = new Interval(0.1, 0.7);

  final Interval item1OpenCurve = new Interval(0.0, 0.3);
  final Interval item2OpenCurve = new Interval(0.1, 0.4);
  final Interval item3OpenCurve = new Interval(0.2, 0.5);
  final Interval item4OpenCurve = new Interval(0.3, 0.6);
  final Interval allItemsCloseCurve = new Interval(0.8, 1.0);

  final Interval opacityCurve = new Interval(0.3, 0.8);

  _Menu({
    this.menuOpenPercent = 1.0,
    this.isMenuOpening = true,
  });

  @override
  Widget build(BuildContext context) {
    // ITEM SELECTOR TRANSFORMATIONS
    final selectorPercent = Curves.easeOut.transform(
        isMenuOpening
            ? selectorSlideOpenCurve.transform(menuOpenPercent)
            : selectorSlideCloseCurve.transform(menuOpenPercent)
    );
    final selectorOffset = 300.0 * (1.0 - selectorPercent);
    final selectorOpacity = Curves.easeOut.transform(
        isMenuOpening
            ? selectorOpacityOpenCurve.transform(selectorPercent)
            : selectorOpacityCloseCurve.transform(selectorPercent)
    );

    // MENU ITEM TRANSFORMATIONS
    final allItemsClosePercent = Curves.easeOut.transform(
        allItemsCloseCurve.transform(menuOpenPercent)
    );

    final item1Percent = Curves.easeOut.transform(
      item1OpenCurve.transform(menuOpenPercent),
    );
    final item1Offset = isMenuOpening
        ? 100.0 * (1.0 - item1Percent)
        : 100.0 * (1.0 - allItemsClosePercent);
    final item1Opacity = Curves.easeOut.transform(
        isMenuOpening
            ? opacityCurve.transform(
          item1OpenCurve.transform(menuOpenPercent),
        )
            : opacityCurve.transform(allItemsClosePercent)
    );

    final item2Percent = Curves.easeOut.transform(
      item2OpenCurve.transform(menuOpenPercent),
    );
    final item2Offset = isMenuOpening
        ? 200.0 * (1.0 - item2Percent)
        : 100.0 * (1.0 - allItemsClosePercent);
    final item2Opacity = Curves.easeOut.transform(
        isMenuOpening
            ? opacityCurve.transform(
          item2OpenCurve.transform(menuOpenPercent),
        )
            : opacityCurve.transform(allItemsClosePercent)
    );

    final item3Percent = Curves.easeOut.transform(
      item3OpenCurve.transform(menuOpenPercent),
    );
    final item3Offset = isMenuOpening
        ? 300.0 * (1.0 - item3Percent)
        : 100.0 * (1.0 - allItemsClosePercent);
    final item3Opacity = Curves.easeOut.transform(
        isMenuOpening
            ? opacityCurve.transform(
          item3OpenCurve.transform(menuOpenPercent),
        )
            : opacityCurve.transform(allItemsClosePercent)
    );

    final item4Percent = Curves.easeOut.transform(
      item4OpenCurve.transform(menuOpenPercent),
    );
    final item4Offset = isMenuOpening
        ? 400.0 * (1.0 - item4Percent)
        : 100.0 * (1.0 - allItemsClosePercent);
    final item4Opacity = Curves.easeOut.transform(
        isMenuOpening
            ? opacityCurve.transform(
          item4OpenCurve.transform(menuOpenPercent),
        )
            : opacityCurve.transform(allItemsClosePercent)
    );

    return new Transform(
      transform: new Matrix4.translationValues(0.0, 230.0, 0.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Transform(
            transform: new Matrix4.translationValues(0.0, selectorOffset + 15.0, 0.0),
            child: new Opacity(
              opacity: selectorOpacity,
              child: new Container(
                width: 5.0,
                height: 35.0,
                color: Colors.red,
              ),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Transform(
                transform: new Matrix4.translationValues(0.0, item1Offset, 0.0),
                child: new Opacity(
                  opacity: item1Opacity,
                  child: new _MenuItem(
                    text: "THE PADDOCK",
                    isSelected: true,
                  ),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(0.0, item2Offset, 0.0),
                child: new Opacity(
                  opacity: item2Opacity,
                  child: new _MenuItem(
                    text: "THE HERO",
                    isSelected: false,
                  ),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(0.0, item3Offset, 0.0),
                child: new Opacity(
                  opacity: item3Opacity,
                  child: new _MenuItem(
                    text: "HELP US GROW",
                    isSelected: false,
                  ),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(0.0, item4Offset, 0.0),
                child: new Opacity(
                  opacity: item4Opacity,
                  child: new _MenuItem(
                    text: "SETTINGS",
                    isSelected: false,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class _MenuItem extends StatelessWidget {

  final String text;
  final bool isSelected;

  _MenuItem({
    this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Text(
        text,
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