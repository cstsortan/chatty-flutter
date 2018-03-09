// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

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

Serializer<User> _$userSerializer = new _$UserSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable serialize(Serializers serializers, User object,
      {FullType specifiedType: FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'userUid',
      serializers.serialize(object.userUid,
          specifiedType: const FullType(String)),
      'profilePic',
      serializers.serialize(object.profilePic,
          specifiedType: const FullType(String)),
      'isAnonymous',
      serializers.serialize(object.isAnonymous,
          specifiedType: const FullType(bool)),
      'provider',
      serializers.serialize(object.provider,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userUid':
          result.userUid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'profilePic':
          result.profilePic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isAnonymous':
          result.isAnonymous = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'provider':
          result.provider = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final String name;
  @override
  final String email;
  @override
  final String userUid;
  @override
  final String profilePic;
  @override
  final bool isAnonymous;
  @override
  final String provider;

  factory _$User([void updates(UserBuilder b)]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.name,
      this.email,
      this.userUid,
      this.profilePic,
      this.isAnonymous,
      this.provider})
      : super._() {
    if (name == null) throw new BuiltValueNullFieldError('User', 'name');
    if (email == null) throw new BuiltValueNullFieldError('User', 'email');
    if (userUid == null) throw new BuiltValueNullFieldError('User', 'userUid');
    if (profilePic == null)
      throw new BuiltValueNullFieldError('User', 'profilePic');
    if (isAnonymous == null)
      throw new BuiltValueNullFieldError('User', 'isAnonymous');
    if (provider == null)
      throw new BuiltValueNullFieldError('User', 'provider');
  }

  @override
  User rebuild(void updates(UserBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    return name == other.name &&
        email == other.email &&
        userUid == other.userUid &&
        profilePic == other.profilePic &&
        isAnonymous == other.isAnonymous &&
        provider == other.provider;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, name.hashCode), email.hashCode),
                    userUid.hashCode),
                profilePic.hashCode),
            isAnonymous.hashCode),
        provider.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('name', name)
          ..add('email', email)
          ..add('userUid', userUid)
          ..add('profilePic', profilePic)
          ..add('isAnonymous', isAnonymous)
          ..add('provider', provider))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _userUid;
  String get userUid => _$this._userUid;
  set userUid(String userUid) => _$this._userUid = userUid;

  String _profilePic;
  String get profilePic => _$this._profilePic;
  set profilePic(String profilePic) => _$this._profilePic = profilePic;

  bool _isAnonymous;
  bool get isAnonymous => _$this._isAnonymous;
  set isAnonymous(bool isAnonymous) => _$this._isAnonymous = isAnonymous;

  String _provider;
  String get provider => _$this._provider;
  set provider(String provider) => _$this._provider = provider;

  UserBuilder();

  UserBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _email = _$v.email;
      _userUid = _$v.userUid;
      _profilePic = _$v.profilePic;
      _isAnonymous = _$v.isAnonymous;
      _provider = _$v.provider;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$User;
  }

  @override
  void update(void updates(UserBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            name: name,
            email: email,
            userUid: userUid,
            profilePic: profilePic,
            isAnonymous: isAnonymous,
            provider: provider);
    replace(_$result);
    return _$result;
  }
}
