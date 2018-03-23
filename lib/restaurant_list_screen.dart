import 'package:flutter/material.dart';

class RestaurantListScreen extends StatefulWidget {

  final isZoomedOut;
  final onMenuTap;

  RestaurantListScreen({
    this.isZoomedOut = false,
    this.onMenuTap
  });

  @override
  _ContentScreenState createState() => new _ContentScreenState();
}

class _ContentScreenState extends State<RestaurantListScreen> {

  @override
  Widget build(BuildContext context) {
    return new Container(
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
        borderRadius: widget.isZoomedOut
            ? new BorderRadius.circular(15.0)
            : new BorderRadius.circular(0.0),
        child: new Container(
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
                    if (null != widget.onMenuTap) {
                      widget.onMenuTap();
                    }
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
                  new _FoodCard(
                    photoAssetPath: 'assets/eggs_in_skillet.jpg',
                    icon: Icons.fastfood,
                    iconBackgroundColor: Colors.orange,
                    title: 'il domacca',
                    subtitle: '78 5th Avenue, New York',
                    likeCount: 84,
                  ),
                  new _FoodCard(
                    photoAssetPath: 'assets/steak_on_cooktop.jpg',
                    icon: Icons.local_dining,
                    iconBackgroundColor: Colors.red,
                    title: 'Mc Grady',
                    subtitle: '79 5th Avenue, New York',
                    likeCount: 84,
                  ),
                  new _FoodCard(
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
        ),
      ),
    );
  }
}

class _FoodCard extends StatelessWidget {

  final String photoAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final int likeCount;

  _FoodCard({
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
              width: double.infinity,
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