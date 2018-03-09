//import 'dart:async';
//
//import 'package:built_redux/built_redux.dart';
//import 'package:chatty/actions/actions.dart';
//import 'package:chatty/data/AppRepository.dart';
//import 'package:chatty/models/app_state.dart';
//import 'package:chatty/models/email_login_info.dart';
//
//class LoginMiddleware {
//  LoginMiddleware(this.repository);
//  final AppRepository repository;
//
//  Future<Null> handle(MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
//      ActionHandler next,
//      Action<EmailLoginInfo> action) async {
//
//    next(action);
//
//    return repository.firAuth.login(action.payload);
//
//  }
//}