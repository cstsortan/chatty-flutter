import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:chatty/actions/actions.dart';
import 'package:chatty/data/AppRepository.dart';
import 'package:chatty/data/services/fir_auth.dart';
import 'package:chatty/data/services/fir_chat.dart';
import 'package:chatty/models/app_state.dart';
import 'package:chatty/presentation/login/login_page.dart';
import 'package:chatty/reducers/reducers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'chat.dart';
import 'middleware/middleware.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

const platform = const MethodChannel('com.d4vinci.chatty');
Future<Null> startLogin() {
  return platform.invokeMethod('startLogin');
}

final router = new Router();

var currentUser;

void defineRoutes(Router router) {
  router.define("/contactsChat/:userUid/:contactUid", handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new PrivateChat(params["contactUid"], params['userUid']);
  }));
}

void main() {
  final store = new Store<AppState, AppStateBuilder, AppActions>(
      reducerBuilder.build(), new AppState(), new AppActions(),
      middleware: [
        createMiddleware(new AppRepository(
          new FirAuth(),
          new FirChat(),
        )),
      ]);

  FirebaseAuth.instance.onAuthStateChanged.listen((user) {
    currentUser = user;
  });

  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {

  final Store<AppState, AppStateBuilder, AppActions> store;
  MyApp(this.store);
  @override
  Widget build(BuildContext context) {
    return new ReduxProvider(
      store: store,
      child: new MaterialApp(
        home: new Center(
          child: new IconButton(
            icon: new Icon(Icons.send),
            onPressed: () {
              startLogin();
            },
          ),
        ),
        onGenerateRoute: router.generator,
      ),
    );
  }
}
