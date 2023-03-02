import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User(
      {int? id,
      String? userName,
      String? email,
      String? password,
      String? accessToken,
      String? refreshToken,
      String? salt,
      String? hashPassword}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
