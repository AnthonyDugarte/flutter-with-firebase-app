import "package:flutter/material.dart";
import 'package:flutter_with_firebase_course/pages/auth/loading_page.dart';
import 'package:flutter_with_firebase_course/pages/auth/login_page.dart';
import 'package:flutter_with_firebase_course/pages/auth/register_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Navigator(
        initialRoute: "auth/loading",
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;

          switch (settings.name) {
            case 'auth/login':
              builder = (BuildContext _) => LoginPage(
                    goApp: () => Navigator.of(context).pop(),
                  );
              break;

            case 'auth/register':
              builder = (BuildContext _) => RegisterPage(
                    goApp: () => Navigator.of(context).pop(),
                  );
              break;

            case 'auth/loading':
              builder = (BuildContext _) => LoadingPage(
                    goApp: () => Navigator.of(context).pop(),
                  );
              break;

            default:
              throw Exception('Invalid route: ${settings.name}');
          }
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      );
}
