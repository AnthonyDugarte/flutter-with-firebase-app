import 'package:flutter/material.dart';
import 'package:flutter_with_firebase_course/pages/auth/root_page.dart';
import 'package:flutter_with_firebase_course/pages/home/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrummy Key',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'auth',
      routes: <String, WidgetBuilder>{
        "home": (BuildContext context) => HomePage(),
        "auth": (BuildContext context) => AuthPage(),
      },
    );
  }
}
