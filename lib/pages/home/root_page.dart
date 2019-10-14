import "package:flutter/material.dart";
import 'package:flutter_with_firebase_course/models/auth.dart';

class HomePage extends StatelessWidget {
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    "/auth", (Route<dynamic> r) => r == null);
              },
            ),
          ],
        ),
        body: Container(
          child: null,
        ),
      );
}
