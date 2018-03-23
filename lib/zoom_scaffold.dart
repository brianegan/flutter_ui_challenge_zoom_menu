import 'package:flutter/material.dart';
import 'package:zoom_menu/menu.dart';
import 'package:zoom_menu/restaurant_list_screen.dart';
import 'package:zoom_menu/underneath_menu_screen.dart';

class ZoomScaffold extends StatefulWidget {

  final Menu menu;

  ZoomScaffold({
    this.menu,
  });

  @override
  _ZoomScaffoldState createState() => new _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold> with TickerProviderStateMixin {

  double menuOpenPercent = 0.0;
  bool isMenuOpen = false;
  bool isMenuOpening = true;

  AnimationController openMenuController;

  final Interval contentZoomOutSubset2 = new Interval(0.0, 0.2);
  final Interval contentSlideOutSubset2 = new Interval(0.1, 0.3);

  final Interval contentZoomAndSlideInSubset = new Interval(0.0, 0.3);

  _ZoomScaffoldState() {
    openMenuController = new AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {
          menuOpenPercent = openMenuController.value;
        });
      });
  }

  toggle() {
    if (isMenuOpen) {
      isMenuOpen = false;
      isMenuOpening = false;
      openMenuController.reverse(from: 1.0);
    } else {
      isMenuOpen = true;
      isMenuOpening = true;
      openMenuController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final zoomOutPercent = isMenuOpening
        ? Curves.easeOut.transform(
        contentZoomOutSubset2.transform(menuOpenPercent)
    )
        : 1.0 - Curves.easeOut.transform(
        contentZoomAndSlideInSubset.transform(1.0 - menuOpenPercent)
    );
    final scale = 1.0 - (0.2 * zoomOutPercent);

    final slidePercent = isMenuOpening
        ? Curves.easeOut.transform(
        contentSlideOutSubset2.transform(menuOpenPercent)
    )
        : 1.0 - Curves.easeOut.transform(
        contentZoomAndSlideInSubset.transform(1.0 - menuOpenPercent)
    );
    final horizontalOffset = 250.0 * slidePercent;

    return new Stack(
        children: [
          new UnderneathMenuScreen(
            menuOpenPercent: menuOpenPercent,
            isMenuOpening: isMenuOpening,
          ),
          new Transform(
            transform: new Matrix4.identity()
              ..scale(scale, scale, 1.0)
              ..translate(horizontalOffset, 0.0, 0.0),
            alignment: Alignment.center,
            child: new Container(
              decoration: new BoxDecoration(
                boxShadow: const [
                  const BoxShadow(
                    color: const Color(0xFF222222),
                    blurRadius: 30.0,
                  ),
                  const BoxShadow(
                    color: const Color(0xFF111111),
                    offset: const Offset(0.0, 5.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: new ClipRRect(
                borderRadius: menuOpenPercent > 0.0
                  ? new BorderRadius.circular(15.0)
                  : new BorderRadius.circular(0.0),
                child: new RestaurantListScreen(
                  onMenuTap: toggle,
                  isZoomedOut: menuOpenPercent > 0.0,
                ),
              ),
            ),
          ),
        ]
    );
  }
}
