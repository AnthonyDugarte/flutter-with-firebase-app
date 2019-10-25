import "package:flutter/material.dart";
import 'package:flutter_with_firebase_course/models/auth.dart';
import 'package:flutter_with_firebase_course/pages/home/animal/form_page.dart';
import 'package:flutter_with_firebase_course/pages/home/animal/listview_animal.dart';

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
                  "auth",
                  (Route<dynamic> r) => r == null,
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => AnimalFormPage(),
            ),
          ),
          shape: StadiumBorder(),
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            size: 20.0,
          ),
        ),
        body: ListViewAnimal(context: context),
      );
}
