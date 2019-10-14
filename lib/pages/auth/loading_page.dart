import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class LoadingPage extends StatefulWidget {
  final VoidCallback goApp;

  LoadingPage({Key key, @required this.goApp}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _checkSession();
  }

  Future<void> _checkSession() async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    if (user != null)
      widget.goApp();
    else
      Navigator.of(context).pushReplacementNamed("auth/login");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      );
}
