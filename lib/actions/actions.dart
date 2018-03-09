library app_actions;

import 'package:built_redux/built_redux.dart';
import 'package:chatty/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'actions.g.dart';

abstract class AppActions extends ReduxActions {
  AppActions._();
  factory AppActions() => new _$AppActions();

  ActionDispatcher<Null> signIn;
  ActionDispatcher<Null> logout;
  ActionDispatcher<User> userLoggedIn;
  ActionDispatcher<FirebaseUser> authStateChanged;

}