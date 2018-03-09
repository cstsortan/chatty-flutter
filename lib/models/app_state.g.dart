// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable serialize(Serializers serializers, AppState object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'isLoggingIn',
      serializers.serialize(object.isLoggingIn,
          specifiedType: const FullType(bool)),
    ];
    if (object.currentUser != null) {
      result
        ..add('currentUser')
        ..add(serializers.serialize(object.currentUser,
            specifiedType: const FullType(User)));
    }
    if (object.authState != null) {
      result
        ..add('authState')
        ..add(serializers.serialize(object.authState,
            specifiedType: const FullType(FirebaseUser)));
    }

    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'currentUser':
          result.currentUser.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'isLoggingIn':
          result.isLoggingIn = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'authState':
          result.authState = serializers.deserialize(value,
              specifiedType: const FullType(FirebaseUser)) as FirebaseUser;
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final User currentUser;
  @override
  final bool isLoggingIn;
  @override
  final FirebaseUser authState;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.currentUser, this.isLoggingIn, this.authState})
      : super._() {
    if (isLoggingIn == null)
      throw new BuiltValueNullFieldError('AppState', 'isLoggingIn');
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppState) return false;
    return currentUser == other.currentUser &&
        isLoggingIn == other.isLoggingIn &&
        authState == other.authState;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, currentUser.hashCode), isLoggingIn.hashCode),
        authState.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('currentUser', currentUser)
          ..add('isLoggingIn', isLoggingIn)
          ..add('authState', authState))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  UserBuilder _currentUser;
  UserBuilder get currentUser => _$this._currentUser ??= new UserBuilder();
  set currentUser(UserBuilder currentUser) => _$this._currentUser = currentUser;

  bool _isLoggingIn;
  bool get isLoggingIn => _$this._isLoggingIn;
  set isLoggingIn(bool isLoggingIn) => _$this._isLoggingIn = isLoggingIn;

  FirebaseUser _authState;
  FirebaseUser get authState => _$this._authState;
  set authState(FirebaseUser authState) => _$this._authState = authState;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _currentUser = _$v.currentUser?.toBuilder();
      _isLoggingIn = _$v.isLoggingIn;
      _authState = _$v.authState;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              currentUser: _currentUser?.build(),
              isLoggingIn: isLoggingIn,
              authState: authState);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'currentUser';
        _currentUser?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
