import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
part 'message.g.dart';

abstract class Message implements Built<Message, MessageBuilder> {
  static Serializer<Message> get serializer => _$messageSerializer;
  Message._();
  factory Message([updates(MessageBuilder b)]) = _$Message;
}