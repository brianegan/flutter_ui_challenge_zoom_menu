import 'package:flutter/material.dart';
import 'package:zoom_menu/menu.dart';
import 'package:zoom_menu/prototools.dart';
import 'package:zoom_menu/restaurant_list_screen.dart';
import 'package:zoom_menu/underneath_menu_screen.dart';

void main() => runApp(new MyApp());

final paleoPaddockMenu = new Menu(
  menuItems: [
    new MenuItem(
      title: 'THE PADDOCK',
      screenBuilder: new ScreenBuilder(
        backgroundBuilder: (BuildContext context) {
          return new Container();
        },
        contentBuilder: (BuildContext context) {
          return new RestaurantListScreen(
            isZoomedOut: false,
            onMenuTap: () {},
          );
        },
      ),
    ),

    new MenuItem(
      title: 'THE HERO',
      screenBuilder: new ScreenBuilder(
        backgroundBuilder: (BuildContext context) {
          return new Container();
        },
        contentBuilder: (BuildContext context) {
          return new Container();
        },
      ),
    ),

    new MenuItem(
      title: 'HELP US GROW',
      screenBuilder: new ScreenBuilder(
        backgroundBuilder: (BuildContext context) {
          return new Container();
        },
        contentBuilder: (BuildContext context) {
          return new Container();
        },
      ),
    ),

    new MenuItem(
      title: 'SETTINGS',
      screenBuilder: new ScreenBuilder(
        backgroundBuilder: (BuildContext context) {
          return new Container();
        },
        contentBuilder: (BuildContext context) {
          return new Container();
        },
      ),
    ),
  ]
);

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  double menuOpenPercent = 0.0;
  bool isMenuOpen = false;
  bool isMenuOpening = true;

  AnimationController openMenuController;

  final InnerAnimationCurve contentZoomOutSubset = new InnerAnimationCurve(0.0, 0.2);
  final InnerAnimationCurve contentSlideOutSubset = new InnerAnimationCurve(0.1, 0.3);

  final InnerAnimationCurve contentZoomAndSlideInSubset = new InnerAnimationCurve(0.0, 0.3);

  _MyHomePageState() {
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
            contentZoomOutSubset.transform(menuOpenPercent)
          )
        : 1.0 - Curves.easeOut.transform(
            contentZoomAndSlideInSubset.transform(1.0 - menuOpenPercent)
          );
    final scale = 1.0 - (0.2 * zoomOutPercent);

    final slidePercent = isMenuOpening
      ? Curves.easeOut.transform(
          contentSlideOutSubset.transform(menuOpenPercent)
        )
      : 1.0 - Curves.easeOut.transform(
          contentZoomAndSlideInSubset.transform(1.0 - menuOpenPercent)
        );
    final horizontalOffset = 250.0 * slidePercent;

    return new Scaffold(
      body: new Stack(
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
            child: new RestaurantListScreen(
              onMenuTap: toggle,
              isZoomedOut: menuOpenPercent > 0.0,
            ),
          ),
        ]
      ),
    );
  }
}