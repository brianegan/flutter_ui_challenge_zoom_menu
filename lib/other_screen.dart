import 'package:flutter/material.dart';

class OtherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: new Center(
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
    );
  }
}
