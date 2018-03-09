import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  User._();
  factory User([updates(UserBuilder b)]) = _$User;

  static Serializer<User> get serializer => _$userSerializer;

  String get name;
  String get email;
  String get userUid;
  String get profilePic;
  bool get isAnonymous;
  String get provider;
}
