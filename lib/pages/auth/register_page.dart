import 'package:flutter/material.dart';
import 'package:flutter_with_firebase_course/models/auth.dart';
import 'package:flutter_with_firebase_course/pages/auth/common.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Auth _auth = Auth();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        // backgroundColor: Colors.grey,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: formLogin(),
            ),
          ),
        ),
      );

  List<Widget> formLogin() => [
        padded(
          child: TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Email",
            ),
            autocorrect: false,
          ),
        ),
        padded(
          child: TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "Password",
            ),
            autocorrect: false,
            autofocus: false,
            obscureText: true,
          ),
        ),
        Column(
          children: buttonWidgets(),
        )
      ];

  List<Widget> buttonWidgets() {
    return [
      RaisedButton(
        onPressed: validateSubmit,
        color: Colors.blue,
        textColor: Colors.white,
        child: Text("Register"),
      ),
      FlatButton(
        child: Text("Login"),
        onPressed: () =>
            Navigator.of(context).pushReplacementNamed("auth/login"),
      )
    ];
  }

  void validateSubmit() {
    _auth.singUp(
        email: _emailController.text, password: _passwordController.text);
  }
}
