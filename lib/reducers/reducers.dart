import 'package:built_redux/built_redux.dart';
import 'package:chatty/models/app_state.dart';
import 'package:chatty/actions/actions.dart';
import 'package:chatty/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
var reducerBuilder = new ReducerBuilder<AppState, AppStateBuilder>()
    ..add(AppActionsNames.userLoggedIn, userLoggedIn)
    ..add(AppActionsNames.signIn, signIn)
    ..add(AppActionsNames.logout, logout);

//void increase(AppState state, Action<int> action, AppStateBuilder builder) {
//    builder.count += action.payload;
//}
//
//void decrease(AppState state, Action<int> action, AppStateBuilder builder) {
//    builder.count -= action.payload;
//}

void userLoggedIn(AppState state, Action<User> action, AppStateBuilder builder) {
    builder
        ..isLoggingIn = false
        ..currentUser = action.payload?.toBuilder();
}

void logout(AppState state, Action<Null> action, AppStateBuilder builder) {
    builder
        ..currentUser = null;
}

void authStateChanged(AppState state, Action<FirebaseUser> action, AppStateBuilder builder) {
    builder
        ..authState = action.payload;
}

void signIn(AppState state, Action<Null> action, AppStateBuilder builder) {
    builder
        ..isLoggingIn = true;
}