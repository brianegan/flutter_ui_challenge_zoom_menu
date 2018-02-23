import 'package:flutter/material.dart';
import 'package:zoom_menu_proto/prototools.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
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

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: [
          new UnderneathMenuScreen(),
          new ContentScreen(),
        ]
      ),
    );
  }
}

class ContentScreen extends StatefulWidget {
  @override
  _ContentScreenState createState() => new _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/wood_bk.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(
              Icons.menu,
            ),
            onPressed: () {

            }
          ),
          title: new Text("THE PALEO PADDOCK"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: new Center(
          child: new ListView(
            children: [
              new FoodCard(
                photoAssetPath: 'assets/eggs_in_skillet.jpg',
                icon: Icons.fastfood,
                iconBackgroundColor: Colors.orange,
                title: 'il domacca',
                subtitle: '78 5th Avenue, New York',
                likeCount: 84,
              ),
              new FoodCard(
                photoAssetPath: 'assets/steak_on_cooktop.jpg',
                icon: Icons.local_dining,
                iconBackgroundColor: Colors.red,
                title: 'Mc Grady',
                subtitle: '79 5th Avenue, New York',
                likeCount: 84,
              ),
              new FoodCard(
                photoAssetPath: 'assets/spoons_of_spices.jpg',
                icon: Icons.fastfood,
                iconBackgroundColor: Colors.orange,
                title: 'il domacca',
                subtitle: '78 5th Avenue, New York',
                likeCount: 84,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {

  final String photoAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final int likeCount;

  FoodCard({
    this.photoAssetPath,
    this.icon,
    this.iconBackgroundColor,
    this.title,
    this.subtitle,
    this.likeCount,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: new Card(
        elevation: 10.0,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            new Image.asset(
              photoAssetPath,
              width: double.INFINITY,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            new Row(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: new BoxDecoration(
                      color: iconBackgroundColor,
                      borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
                    ),
                    child: new Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                ),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        title,
                        style: const TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'mermaid',
                        ),
                      ),
                      new Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'bebas-neue',
                          letterSpacing: 1.0,
                          color: const Color(0xFFAAAAAA),
                        )
                      )
                    ]
                  ),
                ),
                new Container(
                  width: 2.0,
                  height: 70.0,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                        const Color(0xFFAAAAAA),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: new Column(
                    children: [
                      new Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      new Text(
                        '$likeCount',
                      )
                    ]
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class UnderneathMenuScreen extends StatefulWidget {
  @override
  _UnderneathMenuScreenState createState() => new _UnderneathMenuScreenState();
}

class _UnderneathMenuScreenState extends State<UnderneathMenuScreen> with TickerProviderStateMixin {

  double transitionPercent; // 1.0 for fully transitioned, 0.0 for not at all.

  AnimationController animationController;
  final InnerAnimationCurve titleAnimationCurve = new InnerAnimationCurve(0.0, 0.5);

  _UnderneathMenuScreenState({
    this.transitionPercent = 0.0,
  }) {
    animationController = new AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)
        ..addListener(() {
          setState(() {
            transitionPercent = animationController.value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final menuTitlePercent = Curves.easeOut.transform(
      titleAnimationCurve.transform(transitionPercent)
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
                    color: const Color(0x88333333),
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
          new Menu(
            transitionPercent: transitionPercent,
          ),
          new Column(
            children: [
              new Expanded(
                child: new Container(),
              ),
              new RaisedButton(
                child: new Text('Play'),
                onPressed: () {
                  animationController.forward(from: 0.0);
                }
              ),
              new Slider(
                  value: transitionPercent,
                  onChanged: (newValue) {
                    setState(() => transitionPercent = newValue);
                  }
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {

  final double transitionPercent;

  final InnerAnimationCurve selectorCurve = new InnerAnimationCurve(0.0, 0.45);
  final InnerAnimationCurve selectorOpacityCurve = new InnerAnimationCurve(0.3, 0.9);

  final InnerAnimationCurve item1Curve = new InnerAnimationCurve(0.0, 0.3);
  final InnerAnimationCurve item2Curve = new InnerAnimationCurve(0.1, 0.4);
  final InnerAnimationCurve item3Curve = new InnerAnimationCurve(0.2, 0.5);
  final InnerAnimationCurve item4Curve = new InnerAnimationCurve(0.3, 0.6);

  final InnerAnimationCurve opacityCurve = new InnerAnimationCurve(0.3, 0.8);

  Menu({
    this.transitionPercent = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final selectorPercent = Curves.easeOut.transform(
      selectorCurve.transform(transitionPercent),
    );
    final selectorOffset = 300.0 * (1.0 - selectorPercent);
    final selectorOpacity = Curves.easeOut.transform(
      selectorOpacityCurve.transform(
        selectorCurve.transform(transitionPercent),
      ),
    );

    final item1Percent = Curves.easeOut.transform(
      item1Curve.transform(transitionPercent),
    );
    final item1Offset = 100.0 * (1.0 - item1Percent);
    final item1Opacity = Curves.easeOut.transform(
      opacityCurve.transform(
        item1Curve.transform(transitionPercent),
      ),
    );

    final item2Percent = Curves.easeOut.transform(
      item2Curve.transform(transitionPercent),
    );
    final item2Offset = 200.0 * (1.0 - item2Percent);
    final item2Opacity = Curves.easeOut.transform(
      opacityCurve.transform(
        item2Curve.transform(transitionPercent),
      ),
    );

    final item3Percent = Curves.easeOut.transform(
      item3Curve.transform(transitionPercent),
    );
    final item3Offset = 300.0 * (1.0 - item3Percent);
    final item3Opacity = Curves.easeOut.transform(
      opacityCurve.transform(
        item3Curve.transform(transitionPercent),
      ),
    );

    final item4Percent = Curves.easeOut.transform(
      item4Curve.transform(transitionPercent),
    );
    final item4Offset = 400.0 * (1.0 - item4Percent);
    final item4Opacity = Curves.easeOut.transform(
      opacityCurve.transform(
        item4Curve.transform(transitionPercent),
      ),
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
                  child: new MenuItem(
                    text: "THE PADDOCK",
                    isSelected: true,
                  ),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(0.0, item2Offset, 0.0),
                child: new Opacity(
                  opacity: item2Opacity,
                  child: new MenuItem(
                    text: "THE HERO",
                    isSelected: false,
                  ),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(0.0, item3Offset, 0.0),
                child: new Opacity(
                  opacity: item3Opacity,
                  child: new MenuItem(
                    text: "HELP US GROW",
                    isSelected: false,
                  ),
                ),
              ),
              new Transform(
                transform: new Matrix4.translationValues(0.0, item4Offset, 0.0),
                child: new Opacity(
                  opacity: item4Opacity,
                  child: new MenuItem(
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


class MenuItem extends StatelessWidget {

  final String text;
  final bool isSelected;

  MenuItem({
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
