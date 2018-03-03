import 'package:flutter/material.dart';
import 'package:redux/chat.dart';
import 'package:redux/splash_page.dart';
import 'home_page.dart';
import 'package:fluro/fluro.dart';

final router = new Router();

void defineRoutes(Router router) {
  router.define("/contactsChat/:userUid/:contactUid", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new PrivateChat(params["contactUid"], params['userUid']);
  }));
}

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new SplashPage(),
      onGenerateRoute: router.generator,
    );
  }
}
