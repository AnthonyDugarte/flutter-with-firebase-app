import "package:flutter/material.dart";

Widget scaffolded({Widget child, Widget title}) => Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.0),
        child: child,
      ),
    );
