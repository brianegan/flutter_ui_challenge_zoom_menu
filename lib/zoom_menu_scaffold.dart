import 'package:flutter/material.dart';

class ZoomMenuScaffold extends StatefulWidget {

  final ZoomMenuScreenBuilder menuScreenBuilder;
  final ZoomMenuContentScreenBuilder contentScreenBuilder;

  ZoomMenuScaffold({
    this.menuScreenBuilder,
    this.contentScreenBuilder,
  });

  @override
  _ZoomMenuScaffoldState createState() => new _ZoomMenuScaffoldState();
}

class _ZoomMenuScaffoldState extends State<ZoomMenuScaffold> with TickerProviderStateMixin {

  MenuController menuController;
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    menuController = new MenuController(
      menuTransitionDuration: const Duration(milliseconds: 250),
      vsync: this,
    )
    ..addListener(_onMenuChange);
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  _onMenuChange() {
    setState(() {});
  }

  Widget _scaleAndPositionContentScreen(contentScreen) {
    var contentScale;
    var slideTranslation;
    var contentCornerRadius;

    switch (menuController.state) {
      case MenuState.open:
        contentScale = 0.8;
        slideTranslation = 250.0;
        contentCornerRadius = 10.0;
        break;
      case MenuState.opening:
        contentScale = 1.0 - (0.20 * scaleDownCurve.transform(menuController.openPercent));
        slideTranslation = 250.0 * slideOutCurve.transform(menuController.openPercent);
        contentCornerRadius = 10.0 * menuController.openPercent;
        break;
      case MenuState.closed:
        contentScale = 1.0;
        slideTranslation = 0.0;
        contentCornerRadius = 0.0;
        break;
      case MenuState.closing:
        contentScale = 1.0 - (0.20 * scaleUpCurve.transform(menuController.openPercent));
        slideTranslation = 250.0 * slideInCurve.transform(menuController.openPercent);
        contentCornerRadius = 10.0 * menuController.openPercent;
        break;
    }

    return new Transform(
      transform: new Matrix4
          .translationValues(slideTranslation, 0.0, 0.0)
        ..scale(contentScale, contentScale),
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
          borderRadius: new BorderRadius.circular(contentCornerRadius),
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
          widget.menuScreenBuilder(context, menuController),
          _scaleAndPositionContentScreen(
            new _ContentArea(
              menuController: menuController,
              contentScreen: widget.contentScreenBuilder(context, menuController),
            ),
          ),
        ],
      ),
    );
  }
}

typedef Widget ZoomMenuScreenBuilder(BuildContext context, MenuController menuController);

class _ContentArea extends StatelessWidget {

  final MenuController menuController;
  final ContentScreen contentScreen;

  _ContentArea({
    this.menuController,
    this.contentScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: contentScreen.background,
      ),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          title: new Text(
            contentScreen.title,
            style: new TextStyle(
              fontFamily: 'bebas-neue',
              fontSize: 24.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: new IconButton(
              icon: new Icon(
                Icons.menu,
              ),
              onPressed: () {
                menuController.toggle();
              }
          ),
        ),
        body: contentScreen.content,
      ),
    );
  }
}

class ContentScreen {
  final String title;
  final DecorationImage background;
  final Widget content;

  ContentScreen({
    this.title,
    this.background,
    this.content,
  });
}

typedef ContentScreen ZoomMenuContentScreenBuilder(BuildContext context, MenuController menuController);

class MenuController extends ChangeNotifier {
  final Duration menuTransitionDuration;
  final AnimationController _animationController;
  MenuState state = MenuState.closed;

  MenuController({
    this.menuTransitionDuration,
    vsync,
  }) : _animationController = new AnimationController(
      duration: menuTransitionDuration,
      vsync: vsync
  ) {
    _animationController
    ..addListener(() {
      notifyListeners();
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        state = MenuState.closed;
      } else if (status == AnimationStatus.completed) {
        state = MenuState.open;
      }
      notifyListeners();
    });
  }

  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get openPercent {
    return _animationController.value;
  }

  open() {
    if (state == MenuState.closed) {
      state = MenuState.opening;
      _animationController.forward(from: 0.0);

      notifyListeners();
    }
  }

  close() {
    if (state == MenuState.open) {
      state = MenuState.closing;
      _animationController.reverse(from: 1.0);

      notifyListeners();
    }
  }

  toggle() {
    if (state == MenuState.closed) {
      open();
    } else if (state == MenuState.open) {
      close();
    }
  }
}

enum MenuState {
  closing,
  closed,
  opening,
  open,
}