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
        body: new Container(),
      ),
    );
  }
}