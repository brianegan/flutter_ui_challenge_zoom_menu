import 'package:flutter/material.dart';
import 'package:zoom_menu/zoom_scaffold.dart';

final otherScreen = new Screen(
  title: 'THE OTHER SCREEN',
  background: new DecorationImage(
    image: new AssetImage('assets/space_bk.jpg'),
    fit: BoxFit.cover,
  ),
  contentBuilder: (BuildContext context) {
    return new OtherScreenContent();
  }
);

class OtherScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: new Center(
        child: Container(
          height: 300.0,
          child: new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Card(
              color: Colors.white,
              child: new Center(
                child: new Text(
                  'This is another screen!',
                  style: new TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
