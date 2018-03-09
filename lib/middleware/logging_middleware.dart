import 'package:built_redux/built_redux.dart';
NextActionHandler loggingMiddleware(MiddlewareApi api) {
  return (ActionHandler next) => (Action action) {
    final prevState = api.state;
    print('Action: $action');
    print('Previous state: $prevState');
    next(action);
    if(prevState != api.state) {
      print('Action: $action');
      print('Resulting state: ${api.state}');
    }
  };
}