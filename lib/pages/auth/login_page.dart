import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_firebase_course/models/auth.dart';
import 'package:flutter_with_firebase_course/pages/auth/common.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => scaffolded(
        title: Text("Login"),
        child: LoginPageView(),
      );
}

class LoginPageView extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageView> {
  final Auth _auth = Auth();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) => Form(
        key: _formkey,
        child: Column(
          children: [
            ...inputBoxes(),
            ...buttonWidgets(),
          ],
        ),
      );

  List<Widget> inputBoxes() => [
        padded(
          child: TextFormField(
            controller: _emailController,
            readOnly: loading,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Email",
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (String v) {
              if (v.isEmpty) return "Email is required";
              if (!valdEmailRegex.hasMatch(v)) return "Email is not valid";
              return null;
            },
            autocorrect: false,
          ),
        ),
        padded(
          child: TextFormField(
            controller: _passwordController,
            readOnly: loading,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "Password",
            ),
            keyboardType: TextInputType.visiblePassword,
            validator: (String v) {
              if (v.isEmpty) return "Password is required";
              return null;
            },
            autocorrect: false,
            autofocus: false,
            obscureText: true,
          ),
        ),
      ];

  List<Widget> buttonWidgets() => [
        RaisedButton(
          onPressed: loading ? null : validateSubmit,
          color: Colors.blue,
          textColor: Colors.white,
          child: Text("Login"),
        ),
        FlatButton(
            child: Text("Create an account."),
            onPressed: loading ? null : goToRegister),
      ];

  Future<void> validateSubmit() async {
    if (!_formkey.currentState.validate()) return;

    setState(() => loading = true);

    try {
      await _auth.singIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );

      _passwordController.clear();
    }

    setState(() => loading = false);
  }

  void goToRegister() =>
      Navigator.of(context).pushReplacementNamed("auth/register");
}
