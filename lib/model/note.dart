import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';

part 'note.g.dart';

@freezed
class Note with _$Note {
  const factory Note({
    required int? id,
    required String? name,
    required String? content,
    required DateTime? createdDate,
    required DateTime? editedDat,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
