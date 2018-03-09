import 'package:built_redux/built_redux.dart';
import 'package:chatty/actions/actions.dart';
import 'package:chatty/models/app_state.dart';
import 'package:chatty/models/email_login_info.dart';
import 'package:test/test.dart';
import 'package:chatty/reducers/reducers.dart';

void main() {
  group('Login results test', () {
    Store<AppState, AppStateBuilder, AppActions> store;

    setUp(() {
      var actions = new AppActions();
      var defaultValue = new AppState();
      store = new Store<AppState, AppStateBuilder, AppActions>(
          reducerBuilder.build(), defaultValue, actions);
    });

    tearDown(() {
      store.dispose();
    });

    test('Handles loging in with given user data', () {
      expect(store.state.isLoggingIn, false);
      store.actions.signIn();
      expect(store.state.isLoggingIn, true);
    });
  });
}
