import 'package:flutter/material.dart';

class ZoomMenuScaffold extends StatefulWidget {

  final ZoomMenuScreenBuilder menuScreenBuilder;
  final ZoomMenuScreenBuilder contentScreenBuilder;

  ZoomMenuScaffold({
    this.menuScreenBuilder,
    this.contentScreenBuilder,
  });

  @override
  _ZoomMenuScaffoldState createState() => new _ZoomMenuScaffoldState();
}

class _ZoomMenuScaffoldState extends State<ZoomMenuScaffold> with TickerProviderStateMixin {

  MenuController menuController;

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
    final contentScale = 1.0 - (0.20 * menuController.openPercent);
    final slideTranslation = 250.0 * menuController.openPercent;

    final contentCornerRadius = 10.0 * menuController.openPercent;

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
            widget.contentScreenBuilder(context, menuController),
          ),
        ],
      ),
    );
  }
}

typedef Widget ZoomMenuScreenBuilder(BuildContext context, MenuController menuController);

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