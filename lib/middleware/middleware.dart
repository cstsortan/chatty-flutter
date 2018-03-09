import 'package:built_redux/built_redux.dart';
import 'package:chatty/actions/actions.dart';
import 'package:chatty/data/AppRepository.dart';
import 'package:chatty/middleware/auth_state_changed_middleware.dart';
import 'sign_in_middleware.dart';
import 'package:chatty/models/app_state.dart';

Middleware<AppState, AppStateBuilder, AppActions> createMiddleware(
    AppRepository repository) =>
    (new MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
//        ..add(AppActionsNames.emailLogin, new LoginMiddleware(repository).handle)
        ..add(AppActionsNames.signIn, new SignInMiddleware(repository).handle)
        ..add(AppActionsNames.authStateChanged, new AuthStateChangedMiddleware(repository).handle)
    ).build();
