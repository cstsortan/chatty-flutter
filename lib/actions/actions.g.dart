// GENERATED CODE - DO NOT MODIFY BY HAND

part of app_actions;

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$AppActions extends AppActions {
  factory _$AppActions() => new _$AppActions._();
  _$AppActions._() : super._();

  final ActionDispatcher<Null> signIn =
      new ActionDispatcher<Null>('AppActions-signIn');
  final ActionDispatcher<Null> logout =
      new ActionDispatcher<Null>('AppActions-logout');
  final ActionDispatcher<User> userLoggedIn =
      new ActionDispatcher<User>('AppActions-userLoggedIn');
  final ActionDispatcher<FirebaseUser> authStateChanged =
      new ActionDispatcher<FirebaseUser>('AppActions-authStateChanged');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    signIn.setDispatcher(dispatcher);
    logout.setDispatcher(dispatcher);
    userLoggedIn.setDispatcher(dispatcher);
    authStateChanged.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final ActionName<Null> signIn =
      new ActionName<Null>('AppActions-signIn');
  static final ActionName<Null> logout =
      new ActionName<Null>('AppActions-logout');
  static final ActionName<User> userLoggedIn =
      new ActionName<User>('AppActions-userLoggedIn');
  static final ActionName<FirebaseUser> authStateChanged =
      new ActionName<FirebaseUser>('AppActions-authStateChanged');
}
