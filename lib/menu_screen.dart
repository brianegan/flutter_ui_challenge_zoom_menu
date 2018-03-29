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
          new Transform(
            transform: new Matrix4.translationValues(0.0, 250.0, 0.0),
            child: new _MenuList(
              menuController: widget.menuController,
              animationController: animationController,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuList extends StatefulWidget {

  final MenuController menuController;
  final AnimationController animationController;

  _MenuList({
    this.menuController,
    this.animationController,
  });

  @override
  _MenuListState createState() => new _MenuListState();
}

class _MenuListState extends State<_MenuList> {

  final menuItemTitles = [
    "THE PADDOCK",
    "THE HERO",
    "HELP US GROW",
    "SETTINGS"
  ];

  List<_MenuItemAnimation> listItemAnimations = [];
  int selectedIndex = 0;
  double selectorYPosition = 500.0;
  double selectorHeight = 0.0;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 4; ++i) {
      listItemAnimations.add(
          new _MenuItemAnimation(
            index: i,
            controller: widget.animationController,
          )
      );
    }
  }

  _createListItems() {
    List<Widget> listItems = [];

    for (var i = 0; i < 4; ++i) {
      final listItem = _createListItem(i, menuItemTitles[i], i == selectedIndex);

      if (i == selectedIndex) {
        listItems.add(
            _SelectedMenuItem(
                onPositionChange: _onSelectedItemPositionChange,
                child: listItem
            )
        );
      } else {
        listItems.add(listItem);
      }
    }

    return listItems;
  }

  _createListItem(int index, String title, [bool isSelected = false]) {
    return new Transform(
      transform: new Matrix4.translationValues(
          0.0,
          listItemAnimations[index].translation,
          0.0
      ),
      child: new Opacity(
        opacity: listItemAnimations[index].opacity,
        child: new _MenuItem(
          title: title,
          isSelected: isSelected,
        ),
      ),
    );
  }

  _onSelectedItemPositionChange(newY, newHeight) {
    setState(() {
      selectorYPosition = newY;
      selectorHeight = newHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    var localSelectorYPosition = 0.0;
    if (widget.menuController.state != MenuState.closing
        && widget.menuController.state != MenuState.closed
        && renderBox != null) {
      localSelectorYPosition = renderBox.globalToLocal(new Offset(0.0, selectorYPosition)).dy;
    } else {
      localSelectorYPosition = 300.0;
    }

    return new Stack(
      children: [
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _createListItems(),
        ),
        new MenuSelector(
          yPosition: localSelectorYPosition,
          height: selectorHeight,
          menuState: widget.menuController.state,
          menuPercentOpen: widget.menuController.openPercent,
        ),
      ]
    );
  }
}


class _SelectedMenuItem extends StatefulWidget {

  final Function(double y, double height) onPositionChange;
  final Widget child;

  _SelectedMenuItem({
    this.onPositionChange,
    this.child,
  });

  @override
  _SelectedMenuItemState createState() => new _SelectedMenuItemState();
}

class _SelectedMenuItemState extends State<_SelectedMenuItem> {

  double prevY, prevHeight;

  @override
  Widget build(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    if (renderBox != null) {
      Offset globalPosition = renderBox.localToGlobal(new Offset(0.0, 0.0));
      final newY = globalPosition.dy;
      final newHeight = renderBox.size.height;

      if (newY != prevY && newHeight != prevHeight) {
        print('Updating selected item position.');
        print('Selected item offset: ${globalPosition.dy}');
        print('Selected item size; ${renderBox.size}');
        print('');

        () async {
          widget.onPositionChange(newY, newHeight);
        }();

        prevY = newY;
        prevHeight = newHeight;
      }
    }

    return widget.child;
  }
}

class MenuSelector extends StatefulWidget {

  final double yPosition;
  final double height;
  final MenuState menuState;
  final double menuPercentOpen;

  MenuSelector({
    this.yPosition,
    this.height,
    this.menuState,
    this.menuPercentOpen,
  });

  @override
  _MenuSelectorState createState() => new _MenuSelectorState();
}

class _MenuSelectorState extends State<MenuSelector> {

  final opacityInCurve = new Interval(0.0, 0.7);
  final opacityOutCurve = new Interval(0.5, 1.0);

  @override
  Widget build(BuildContext context) {
    var selectorOpacity;
    if (widget.menuState == MenuState.opening) {
      selectorOpacity = opacityInCurve.transform(widget.menuPercentOpen);
    } else if (widget.menuState == MenuState.closing) {
      selectorOpacity = opacityOutCurve.transform(widget.menuPercentOpen);
    } else {
      selectorOpacity = widget.menuPercentOpen;
    }

    return new AnimatedPositioned(
      left: 0.0,
      top: widget.yPosition,
      duration: const Duration(milliseconds: 150),
      child: new Opacity(
        opacity: selectorOpacity,
        child: new Container(
          width: 5.0,
          height: widget.height,
          color: Colors.red,
        ),
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
        translationCurve = new Interval(index * 0.15, index * 0.15 + 0.30, curve: Curves.easeOut),
        opacityTween = new Tween(begin: 0.0, end: 1.0),
        opacityCurve = new Interval(index * 0.15, index * 0.15 + 0.30, curve: Curves.easeOut) {
    translationCurvedAnimation = new CurvedAnimation(
      parent: controller,
      curve: translationCurve,
      reverseCurve: new Interval(0.75, 1.0, curve: Curves.easeOut),
    );
    translationAnimation = translationTween.animate(translationCurvedAnimation);

    opacityCurvedAnimation = new CurvedAnimation(
      parent: controller,
      curve: opacityCurve,
      reverseCurve: new Interval(0.75, 1.0, curve: Curves.easeOut),
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