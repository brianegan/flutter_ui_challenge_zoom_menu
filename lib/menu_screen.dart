import 'package:flutter/material.dart';
import 'package:zoom_menu/zoom_menu_scaffold.dart';

class MenuScreen extends StatefulWidget {

  final MenuController menuController;

  MenuScreen({
    this.menuController,
  });

  @override
  MenuScreenState createState() {
    return new MenuScreenState();
  }
}

class MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {

  MenuState prevMenuState;

  AnimationController animationController;
  Animation<double> menuTitleTranslationAnimation;
  List<_MenuItemAnimation> listItemAnimations = [];

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    menuTitleTranslationAnimation = new Tween(begin: 150.0, end: -100.0)
      .animate(
        new CurvedAnimation(
          parent: animationController,
          curve: new Interval(0.0, 0.4, curve: Curves.easeOut),
          reverseCurve: new Interval(0.6, 1.0, curve: Curves.easeOut),
        )
        ..addListener(() => setState(() {})),
      );

    for (int i = 0; i < 4; ++i) {
      listItemAnimations.add(
        new _MenuItemAnimation(
          index: i,
          controller: animationController,
        )
      );
    }
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  _animateIfMenuIsTransitioning() {
    if (prevMenuState != widget.menuController.state) {
      if (widget.menuController.state == MenuState.opening) {
        // Animate in the title and list items
        animationController.forward(from: 0.0);
      } else if (widget.menuController.state == MenuState.closing) {
        // Animate out the title and list items
        animationController.reverse(from: 1.0);
      }

      prevMenuState = widget.menuController.state;
    }
  }

  @override
  Widget build(BuildContext context) {
    _animateIfMenuIsTransitioning();

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
          // "Menu" title
          new Transform(
            transform: new Matrix4.translationValues(
                menuTitleTranslationAnimation.value,
                0.0,
                0.0
            ),
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

          // Menu items
          new Transform(
            transform: new Matrix4.translationValues(0.0, 250.0, 0.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0,
                      listItemAnimations[0].translation,
                      0.0
                  ),
                  child: new Opacity(
                    opacity: listItemAnimations[0].opacity,
                    child: new _MenuItem(
                      title: 'THE PADDOCK',
                      isSelected: true,
                    ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0,
                      listItemAnimations[1].translation,
                      0.0
                  ),
                  child: new Opacity(
                    opacity: listItemAnimations[1].opacity,
                    child: new _MenuItem(
                      title: 'THE HERD',
                      isSelected: false,
                    ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0,
                      listItemAnimations[2].translation,
                      0.0
                  ),
                  child: new Opacity(
                    opacity: listItemAnimations[2].opacity,
                    child: new _MenuItem(
                      title: 'HELP US GROW',
                      isSelected: false,
                    ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0,
                      listItemAnimations[3].translation,
                      0.0
                  ),
                  child: new Opacity(
                    opacity: listItemAnimations[3].opacity,
                    child: new _MenuItem(
                      title: 'SETTINGS',
                      isSelected: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItemAnimation {
  final Interval translationCurve;
  final Tween<double> translationTween;
  CurvedAnimation translationCurvedAnimation;
  Animation<double> translationAnimation;

  final Interval opacityCurve;
  final Tween<double> opacityTween;
  CurvedAnimation opacityCurvedAnimation;
  Animation<double> opacityAnimation;

  _MenuItemAnimation({
    int index,
    AnimationController controller,
  })
      : translationTween = new Tween(begin: 200.0, end: 0.0),
        translationCurve = new Interval(index * 0.15, index * 0.15 + 0.15, curve: Curves.easeOut),
        opacityTween = new Tween(begin: 0.0, end: 1.0),
        opacityCurve = new Interval(index * 0.15, index * 0.15 + 0.15, curve: Curves.easeOut) {
    translationCurvedAnimation = new CurvedAnimation(
      parent: controller,
      curve: translationCurve,
      reverseCurve: new Interval(0.85, 1.0, curve: Curves.easeOut),
    );
    translationAnimation = translationTween.animate(translationCurvedAnimation);

    opacityCurvedAnimation = new CurvedAnimation(
      parent: controller,
      curve: opacityCurve,
      reverseCurve: new Interval(0.85, 1.0, curve: Curves.easeOut),
    );
    opacityAnimation = opacityTween.animate(opacityCurvedAnimation);
  }

  get translation => translationAnimation.value;

  get opacity => opacityAnimation.value;
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