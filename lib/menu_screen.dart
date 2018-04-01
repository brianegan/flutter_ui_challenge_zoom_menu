import 'package:flutter/material.dart';
import 'package:zoom_menu/zoom_scaffold.dart';

class MenuScreen extends StatefulWidget {

  final MenuController menuController;
  final Menu menu;
  final String selectedMenuItemId;
  final Function(String) onMenuItemSelected;

  MenuScreen({
    this.menuController,
    this.menu,
    this.selectedMenuItemId,
    this.onMenuItemSelected,
  });

  @override
  _MenuScreenState createState() => new _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  MenuController menuController;

  @override
  void initState() {
    super.initState();
    menuController = widget.menuController
      ..addListener(_onMenuControllerChange);
  }

  @override
  void dispose() {
    menuController.removeListener(_onMenuControllerChange);
    super.dispose();
  }

  _onMenuControllerChange() {
    setState(() {});
  }

  _createMenuTitle() {
    final titleTranslation = 250.0 * (1.0 - menuController.percentOpen) - 100.0;

    return new Transform(
      transform: new Matrix4.translationValues(
          titleTranslation,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ZoomScaffoldMenuController(
      builder: (BuildContext context, MenuController menuController) {
        return new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/dark_grunge_bk.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: new Material(
            color: Colors.transparent,
            child: new Stack(
              children: [
                _createMenuTitle(),

                new Transform(
                  transform: new Matrix4.translationValues(0.0, 225.0, 0.0),
                  child: new _MenuList(
                    menu: widget.menu,
                    menuController: menuController,
                    selectedMenuItemId: widget.selectedMenuItemId,
                    onMenuItemSelected: widget.onMenuItemSelected,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

final _menuListKey = new GlobalKey(debugLabel: '_MenuList');

class _MenuList extends StatefulWidget {

  final Menu menu;
  final MenuController menuController;
  final String selectedMenuItemId;
  final Function(String) onMenuItemSelected;

  _MenuList({
    this.menu,
    this.menuController,
    this.selectedMenuItemId,
    this.onMenuItemSelected,
  }) : super(key:_menuListKey);

  @override
  __MenuListState createState() => new __MenuListState();
}

class __MenuListState extends State<_MenuList> {

  RenderBox selectedItemRenderBox;

  _createMenuList() {
    final slideTime = 200;
    final delayPerItem = widget.menuController.state != MenuState.closing ? 100 : 0;
    var index = 0;
    final listItemWidgets = widget.menu.items.map((MenuItem item) {
      final int delay = index * delayPerItem;
      final int duration = delay + slideTime;
      final interval = new Interval(1.0 - ((duration - delay) / duration), 1.0);
      ++index;

      return _AnimatedMenuListItem(
        menuState: widget.menuController.state,
        duration: new Duration(milliseconds: duration),
        curve: interval,
        isSelected: item.id == widget.selectedMenuItemId,
        menuListItem: new _MenuListItem(
            title: item.title,
            isSelected: item.id == widget.selectedMenuItemId,
            onTap: () {
              widget.menuController.close();
              widget.onMenuItemSelected(item.id);
            }
        ),
      );
    }).toList();

    return new Column(
      children: listItemWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    Offset localOffset;
    var selectorTop, selectorBottom, opacity;
    if (null != selectedItemRenderBox) {
      final globalOffset = selectedItemRenderBox.localToGlobal(const Offset(0.0, 0.0));

      RenderBox myRenderBox = context.findRenderObject() as RenderBox;
      localOffset = myRenderBox.globalToLocal(globalOffset);

      if (widget.menuController.state == MenuState.opening
          || widget.menuController.state == MenuState.open) {
        selectorTop = localOffset.dy;
        selectorBottom = selectorTop + selectedItemRenderBox.size.height;
        opacity = 1.0;
      } else {
        selectorTop = 300.0;
        selectorBottom = 350.0;
        opacity = 0.0;
      }
    } else {
      selectorTop = 300.0;
      selectorBottom = 350.0;
      opacity = 0.0;
    }

    return new Stack(
      children: [
        _createMenuList(),
        new _ItemSelector(
          top: selectorTop,
          bottom: selectorBottom,
          opacity: opacity,
        ),
      ]
    );
  }
}

class _ItemSelector extends ImplicitlyAnimatedWidget {

  final double top;
  final double bottom;
  final double opacity;

  _ItemSelector({
    this.top,
    this.bottom,
    this.opacity,
  }) : super(duration: const Duration(milliseconds: 250));

  @override
  __ItemSelectorState createState() => new __ItemSelectorState();
}

class __ItemSelectorState extends AnimatedWidgetBaseState<_ItemSelector> {

  Tween<double> _top;
  Tween<double> _bottom;
  Tween<double> _opacity;

  @override
  void forEachTween(TweenVisitor visitor) {
    _top = visitor(
      _top,
      widget.top,
      (dynamic value) => new Tween<double>(begin: value),
    );
    _bottom = visitor(
      _bottom,
      widget.bottom,
      (dynamic value) => new Tween<double>(begin: value),
    );
    _opacity = visitor(
      _opacity,
      widget.opacity,
          (dynamic value) => new Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
      top: _top.evaluate(animation),
      child: new Opacity(
        opacity: _opacity.evaluate(animation),
        child: new Container(
          width: 5.0,
          height: _bottom.evaluate(animation) - _top.evaluate(animation),
          color: Colors.red,
        ),
      ),
    );
  }
}

class _AnimatedMenuListItem extends ImplicitlyAnimatedWidget {

  final _MenuListItem menuListItem;
  final MenuState menuState;
  final Duration duration;
  final bool isSelected;

  _AnimatedMenuListItem({
    this.menuListItem,
    this.menuState,
    this.duration,
    this.isSelected,
    curve
  }): super(
    duration: duration,
    curve: curve
  );

  @override
  __AnimatedMenuListItemState createState() => new __AnimatedMenuListItemState();
}

class __AnimatedMenuListItemState extends AnimatedWidgetBaseState<_AnimatedMenuListItem> {

  final double closedSlidePosition = 200.0;
  final double openSlidePosition = 0.0;

  Tween<double> _translation;
  Tween<double> _opacity;

  bool initializedSelectedItem = false;

  @override
  void initState() {
    super.initState();
    _updateSelectedRenderBox();
  }

  _updateSelectedRenderBox() {
    final renderBox = context.findRenderObject() as RenderBox;
    if (widget.isSelected && renderBox != null) {
      (_menuListKey.currentState as __MenuListState).selectedItemRenderBox = renderBox;
    }
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    var slide;
    var opacity;

    switch (widget.menuState) {
      case MenuState.closed:
      case MenuState.closing:
        slide = closedSlidePosition;
        opacity = 0.0;
        break;
      case MenuState.open:
      case MenuState.opening:
        slide = openSlidePosition;
        opacity = 1.0;
        break;
    }

    _translation = visitor(
      _translation,
      slide,
      (dynamic value) => new Tween<double>(begin: value),
    );

    _opacity = visitor(
      _opacity,
      opacity,
      (dynamic value) => new Tween<double>(begin: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    _updateSelectedRenderBox();

    return new Opacity(
      opacity: _opacity.evaluate(animation),
      child: new Transform(
        transform: new Matrix4.translationValues(
            0.0,
            _translation.evaluate(animation),
            0.0
        ),
        child: widget.menuListItem,
      ),
    );
  }
}

class _MenuListItem extends StatelessWidget {

  final String title;
  final bool isSelected;
  final Function() onTap;

  _MenuListItem({
    this.title,
    this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      splashColor: const Color(0x44000000),
      onTap: isSelected ? null : onTap,
      child: new Container(
        width: double.infinity,
        child: new Padding(
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
        ),
      ),
    );
  }
}

class Menu {
  final List<MenuItem> items;

  Menu({
    this.items,
  });
}

class MenuItem {
  final String id;
  final String title;

  MenuItem({
    this.id,
    this.title,
  });
}