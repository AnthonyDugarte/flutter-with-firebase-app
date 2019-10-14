import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_with_firebase_course/models/auth.dart';
import 'package:flutter_with_firebase_course/pages/auth/common.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback finishAuth;

  RegisterPage({Key key, @required this.finishAuth}) : super(key: key);

  @override
  Widget build(BuildContext context) => scaffolded(
        title: Text("Register"),
        child: RegisterPageView(
          finishAuth: finishAuth,
        ),
      );
}

class RegisterPageView extends StatefulWidget {
  final VoidCallback finishAuth;

  RegisterPageView({Key key, @required this.finishAuth}) : super(key: key);

  @override
  _RegisterPageViewState createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  final Auth _auth = Auth();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;
  FocusNode _emailFocus;
  FocusNode _passwordFocus;

  @override
  void initState() {
    super.initState();

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  void focusEmail() => FocusScope.of(context).requestFocus(_emailFocus);
  void focusPassword() => FocusScope.of(context).requestFocus(_passwordFocus);

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
            keyboardType: TextInputType.emailAddress,
            validator: (String v) {
              if (v.isEmpty) return "Email is required";
              if (!validEmailRegex.hasMatch(v)) return "Email is not valid";
              return null;
            },
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Email",
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: focusPassword,
            enabled: !loading,
            autocorrect: false,
            controller: _emailController,
            focusNode: _emailFocus,
          ),
        ),
        padded(
          child: TextFormField(
            keyboardType: TextInputType.visiblePassword,
            validator: (String v) {
              if (v.isEmpty) return "Password is required";
              return null;
            },
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "Password",
            ),
            textInputAction: TextInputAction.done,
            onEditingComplete: validateSubmit,
            enabled: !loading,
            autocorrect: false,
            autofocus: false,
            obscureText: true,
            controller: _passwordController,
            focusNode: _passwordFocus,
          ),
        ),
      ];

  List<Widget> buttonWidgets() => [
        RaisedButton(
          onPressed: loading ? null : validateSubmit,
          child: Text("Register"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
        FlatButton(
          onPressed: loading ? null : goToLogin,
          child: Text("Go to Login"),
        )
      ];

  Future<void> validateSubmit() async {
    if (!_formkey.currentState.validate()) {
      if (_emailController.text.isEmpty)
        focusEmail();
      else
        focusPassword();

      return;
    }

    setState(() => loading = true);

    try {
      String userId = await _auth.singUp(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userId != null) widget.finishAuth();
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );

      _emailController.clear();
      _passwordController.clear();
      FocusScope.of(context).requestFocus(_emailFocus);

      setState(() => loading = false);
    }
  }

  void goToLogin() => Navigator.of(context).pushReplacementNamed("auth/login");
}
