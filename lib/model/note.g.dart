// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      id: json['id'] as int?,
      name: json['name'] as String?,
      content: json['content'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      editedDate: json['editedDate'] == null
          ? null
          : DateTime.parse(json['editedDate'] as String),
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'createdDate': instance.createdDate?.toIso8601String(),
      'editedDate': instance.editedDate?.toIso8601String(),
    };
