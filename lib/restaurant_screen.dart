import 'package:flutter/material.dart';
import 'package:zoom_menu/zoom_menu_scaffold.dart';

class RestaurantScreen extends StatelessWidget {

  final MenuController menuController;

  RestaurantScreen({
    this.menuController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/wood_bk.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: new AppBar(
          title: new Text(
            'THE PALEO PADDOCK',
            style: new TextStyle(
              fontFamily: 'bebas-neue',
              fontSize: 24.0,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: new IconButton(
              icon: new Icon(
                Icons.menu,
              ),
              onPressed: () {
                menuController.toggle();
              }
          ),
        ),
        body: new ListView(
          children: [
            new _RestaurantCard(
              headerImageAssetPath: 'assets/eggs_in_skillet.jpg',
              icon: Icons.fastfood,
              iconBackgroundColor: Colors.orange,
              title: 'il domacca',
              subtitle: '78 5TH AVENUE, NEW YORK',
              heartCount: 84,
            ),
            new _RestaurantCard(
              headerImageAssetPath: 'assets/steak_on_cooktop.jpg',
              icon: Icons.local_dining,
              iconBackgroundColor: Colors.red,
              title: 'Mc Grady',
              subtitle: '79 5TH AVENUE, NEW YORK',
              heartCount: 84,
            ),
            new _RestaurantCard(
              headerImageAssetPath: 'assets/spoons_of_spices.jpg',
              icon: Icons.fastfood,
              iconBackgroundColor: Colors.purpleAccent,
              title: 'Sugar & Spice',
              subtitle: '80 5TH AVENUE, NEW YORK',
              heartCount: 84,
            ),
          ],
        ),
      ),
    );
  }
}

class _RestaurantCard extends StatelessWidget {

  final String headerImageAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final int heartCount;

  _RestaurantCard({
    this.headerImageAssetPath,
    this.icon,
    this.iconBackgroundColor,
    this.title,
    this.subtitle,
    this.heartCount,
  });

  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: new ThemeData(
        brightness: Brightness.light,
      ),
      child: new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: new Card(
          elevation: 10.0,
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              new Image.asset(
                headerImageAssetPath,
                width: double.infinity,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              new Row(
                children: [
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
                        )
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
                          ),
                        ),
                      ],
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
                          '$heartCount',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}