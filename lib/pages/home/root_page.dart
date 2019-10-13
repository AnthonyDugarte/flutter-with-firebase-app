import "package:flutter/material.dart";
import 'package:flutter_with_firebase_course/models/auth.dart';

class HomePage extends StatelessWidget {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            RaisedButton(
              child: Icon(Icons.close),
              onPressed: () {
                debugPrint("HEHE");
                _auth.signOut();
                Navigator.of(context).popAndPushNamed("/auth");
              },
            ),
          ],
        ),
        body: Container(
          child: null,
        ),
      );
}
