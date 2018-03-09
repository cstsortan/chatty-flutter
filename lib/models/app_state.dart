import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:chatty/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;
  AppState._();
  factory AppState([updates(AppStateBuilder b)]) =>
      new _$AppState((builder) {
        builder
        ..currentUser = null
        ..isLoggingIn = false;
      });

  @nullable
  User get currentUser;

  bool get isLoggingIn;

  @nullable
  FirebaseUser get authState;
}
