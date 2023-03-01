import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

@freezed
class User with _$User {
  const factory User(
      {int? id,
      required String? userName,
      String? email,
      required String? password,
      String? accessToken,
      String? refreshToken,
      String? salt,
      String? hashPassword,
      bool? isActive}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
