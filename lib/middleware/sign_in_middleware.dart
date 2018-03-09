import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:chatty/actions/actions.dart';
import 'package:chatty/data/AppRepository.dart';
import 'package:chatty/models/app_state.dart';
import 'package:flutter/services.dart';

const platform = const MethodChannel('com.d4vinci.chatty');
Future<Null> startLogin() {
  return platform.invokeMethod('startLogin');
}

class SignInMiddleware {
  final AppRepository appRepository;
  SignInMiddleware(this.appRepository);

  Future<Null> handle(
    MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
    ActionHandler next,
    Action<bool> action,
  ) async {
    next(action);
    return startLogin();
  }
}
