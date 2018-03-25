import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Zoom Menu',
      theme: new ThemeData(
        brightness: Brightness.dark,
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
          title: new Text('THE PALEO PADDOCK'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: new IconButton(
            icon: new Icon(
              Icons.menu,
            ),
            onPressed: () {

            }
          ),
        ),
        body: new ListView(
          children: [
            new Theme(
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
                        'assets/steak_on_cooktop.jpg',
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
                                color: Colors.orange,
                                borderRadius: new BorderRadius.all(const Radius.circular(15.0)),
                              ),
                              child: new Icon(
                                Icons.fastfood,
                                color: Colors.white,
                              )
                            ),
                          ),
                          new Expanded(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new Text(
                                  'il domacca',
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'mermaid',
                                  ),
                                ),
                                new Text(
                                  '78 5TH AVENUE, NEW YORK',
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
                                  '84',
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
            )
          ],
        ),
      ),
    );
  }
}