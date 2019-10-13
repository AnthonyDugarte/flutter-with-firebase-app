import "package:flutter/material.dart";

Widget padded({Widget child}) => Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );

Widget scaffolded({Widget child, Widget title}) => Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.0),
        child: child,
      ),
    );

RegExp validEmailRegex = new RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
);
