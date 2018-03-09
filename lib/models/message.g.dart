// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

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

Serializer<Message> _$messageSerializer = new _$MessageSerializer();

class _$MessageSerializer implements StructuredSerializer<Message> {
  @override
  final Iterable<Type> types = const [Message, _$Message];
  @override
  final String wireName = 'Message';

  @override
  Iterable serialize(Serializers serializers, Message object,
      {FullType specifiedType: FullType.unspecified}) {
    return <Object>[];
  }

  @override
  Message deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType: FullType.unspecified}) {
    return new MessageBuilder().build();
  }
}

class _$Message extends Message {
  factory _$Message([void updates(MessageBuilder b)]) =>
      (new MessageBuilder()..update(updates)).build();

  _$Message._() : super._();

  @override
  Message rebuild(void updates(MessageBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MessageBuilder toBuilder() => new MessageBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Message) return false;
    return true;
  }

  @override
  int get hashCode {
    return 220065899;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('Message').toString();
  }
}

class MessageBuilder implements Builder<Message, MessageBuilder> {
  _$Message _$v;

  MessageBuilder();

  @override
  void replace(Message other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Message;
  }

  @override
  void update(void updates(MessageBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Message build() {
    final _$result = _$v ?? new _$Message._();
    replace(_$result);
    return _$result;
  }
}
