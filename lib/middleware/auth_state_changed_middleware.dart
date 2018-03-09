import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:chatty/actions/actions.dart';
import 'package:chatty/data/AppRepository.dart';
import 'package:chatty/models/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthStateChangedMiddleware {

  final AppRepository appRepository;
  AuthStateChangedMiddleware(this.appRepository);

  Future<Null> handle(
      MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next,
      Action<FirebaseUser> action,
      ) async {
    next(action);
    FirebaseUser user = action.payload;
    if(user != null) {

    }
  }

}