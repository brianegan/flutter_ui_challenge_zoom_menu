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

class _ZoomMenuScaffoldState extends State<ZoomMenuScaffold> with TickerProviderStateMixin {

  MenuController menuController;

  @override
  void initState() {
    super.initState();
    menuController = new MenuController(
      vsync: this,
    )
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

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
                    menuController.toggle();
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
    final slideAmount = 275.0 * menuController.percentOpen;
    final contentScale = 1.0 - (0.2 * menuController.percentOpen);
    final cornerRadius = 10.0 * menuController.percentOpen;

    return new Transform(
      transform: new Matrix4
        .translationValues(slideAmount, 0.0, 0.0)
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
            ),
          ],
        ),
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(cornerRadius),
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

class ZoomScaffoldMenuController extends StatelessWidget {

  final ZoomScaffoldBuilder builder;

  ZoomScaffoldMenuController({
    this.builder,
  });

  getMenuController(BuildContext context) {
    return _MenuControllerHolder.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, getMenuController(context));
  }
}

typedef Widget ZoomScaffoldBuilder(
  BuildContext context,
  MenuController menuController,
);

class _MenuControllerHolder extends InheritedWidget {

  static MenuController of(BuildContext context) {
    final scaffoldState = context.ancestorStateOfType(
        new TypeMatcher<_ZoomMenuScaffoldState>()
    ) as _ZoomMenuScaffoldState;
    return scaffoldState.menuController;
  }

  @override
  bool updateShouldNotify(_MenuControllerHolder oldWidget) {
    return false;
  }
}

class MenuController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  MenuState state = MenuState.closed;

  MenuController({
    this.vsync,
  }) : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

enum MenuState {
  closed,
  opening,
  open,
  closing,
}