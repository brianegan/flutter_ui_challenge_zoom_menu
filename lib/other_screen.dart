import 'package:flutter/material.dart';
import 'package:zoom_menu/zoom_scaffold.dart';

final otherScreen = new Screen(
  title: 'THE OTHER SCREEN',
  background: new DecorationImage(
    image: new AssetImage('assets/other_screen_bk.jpg'),
    fit: BoxFit.cover,
    colorFilter: new ColorFilter.mode(const Color(0xCC000000), BlendMode.multiply),
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
              child: Column(
                children: [
                  new Image(
                    image: new AssetImage('assets/other_screen_card_photo.jpg'),
                    fit: BoxFit.cover,
                  ),
                  new Expanded(
                    child: new Center(
                      child: new Text(
                        'This is another screen!',
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
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
